@echo off


set STUDIO_PATH=%~dp0..\..
set DOT_STUDIO="%UserProfile%\.studio"

:: Make sure the .studio subdirectories exist
if not exist %DOT_STUDIO%\agent\* mkdir %DOT_STUDIO%\agent
if not exist %DOT_STUDIO%\db\* mkdir %DOT_STUDIO%\db
if not exist %DOT_STUDIO%\library\* mkdir %DOT_STUDIO%\library

:: Copy agent and metadata JARs
copy "%STUDIO_PATH%\agent\target\studio-agent-${project.version}-jar-with-dependencies.jar" %DOT_STUDIO%\agent\studio-agent.jar
copy "%STUDIO_PATH%\metadata\target\studio-metadata-${project.version}-jar-with-dependencies.jar" %DOT_STUDIO%\agent\studio-metadata.jar

java -Dvertx.disableDnsResolver=true -Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager -Dvertx.logger-delegate-factory-class-name=io.vertx.core.logging.Log4j2LogDelegateFactory -Dfile.encoding=UTF-8 -cp "%STUDIO_PATH%/web-ui/${project.build.finalName}.jar";"%STUDIO_PATH%/web-ui/target/lib/*";. io.vertx.core.Launcher run ${vertx.main.verticle}
