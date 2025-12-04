import { PrismaClient } from "@prisma/client";
import { PrismaClientKnownRequestError } from "@prisma/client/runtime/library";

import { hashData } from "../../../etl.js";

const prisma = new PrismaClient();

async function main() {
  const data = await prisma.spadingData.findMany({
    where: {
      project: "Skeleton of Crimbo Past",
    },
  });

  for (const datum of data) {
    const dataHash = hashData(
      datum.data as unknown as Record<string, string | number | boolean>,
    );
    try {
      await prisma.spadingData.update({
        where: { id: datum.id },
        data: {
          dataHash,
        },
      });
    } catch (error) {
      if (
        error instanceof PrismaClientKnownRequestError &&
        error.code === "P2002"
      ) {
        const existing = await prisma.spadingData.findFirst({
          where: { dataHash, version: datum.version, project: datum.project },
        });

        if (existing) {
          await prisma.report.updateMany({
            where: { dataId: datum.id },
            data: { dataId: existing.id },
          });
        }

        await prisma.spadingData.delete({
          where: { id: datum.id },
        });

        console.log(
          "Discarded duplicate row with id",
          datum.id,
          "as it was the same as",
          existing?.id ?? "no other row??",
        );
      }
    }
  }

  console.log(data.length, "rows updated");
}

main()
  .catch(async (e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => await prisma.$disconnect());
