npx create-next-app@14
npm i @ignite-ui/react@latest
npm i @rocketseat/eslint-config -D
npm i react-hook-form @hookform/resolvers zod
npm i prisma -D
npm i @prisma/client
npx prisma init --datasource-provider SQLite
npx prisma migrate dev
npx prisma studio