import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { Logger as NestLogger, ValidationPipe } from '@nestjs/common';
// import { LoggerErrorInterceptor } from 'nestjs-pino';
import { middleware } from './app.middleware';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const configService = app.get<ConfigService>(ConfigService);
  app.setGlobalPrefix('api');

  // app.use(express.urlencoded({ extended: false }));
  // app.use(compression());
  // app.use(cookieParser());

  // app.useLogger(app.get(Logger));
  // app.useGlobalInterceptors(new LoggerErrorInterceptor());

  middleware(app);

  // app.enableShutdownHooks();

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
    }),
  );

  await app.listen(+configService.get('PORT'));
  const url = await app.getUrl();
  NestLogger.log('Application is running on:' + url, 'Bootstrap');
}

bootstrap();

// void (async (): Promise<void> => {
//   try {
//     const url = await bootstrap();
//     NestLogger.log('Application is running on:' + url, 'Bootstrap');
//   } catch (error) {
//     NestLogger.error(error, 'Bootstrap');
//   }
// })();
