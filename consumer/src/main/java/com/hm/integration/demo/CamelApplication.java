package com.hm.integration.demo;

import org.springframework.context.ApplicationContext;
import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.apache.camel.spring.boot.CamelSpringBootApplicationController;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.apache.activemq.ActiveMQConnectionFactory;
import javax.jms.ConnectionFactory;
import org.springframework.beans.factory.annotation.*;

import org.apache.qpid.jms.JmsConnectionFactory;
import org.springframework.jms.connection.CachingConnectionFactory;

import org.apache.camel.component.amqp.AMQPConnectionDetails;
/**
 * A sample Spring Boot application that starts the Camel routes.
 */
@SpringBootApplication
@EnableAutoConfiguration
public class CamelApplication {

  /*
   * Injecting property from OS environment variable
   */
  @Value("${BROKER_USER}")
  private String brokerUser;

  @Value("${BROKER_PASSWORD}")
  private String brokerPassword;

  @Value("${BROKER_URL}")
  private String brokerUrl;

  @Bean
  AMQPConnectionDetails securedAmqpConnection() {
    return new AMQPConnectionDetails(brokerUrl, brokerUser,brokerPassword);
  }

  @Bean
  public ConnectionFactory connectionFactory() {
    return new CachingConnectionFactory(
      new JmsConnectionFactory(brokerUser,brokerPassword, brokerUrl));
  }

    /**
     * A main method to start this application.
     */
    public static void main(String[] args) throws Exception {

        ApplicationContext applicationContext =
          SpringApplication.run(CamelApplication.class, args);
        CamelSpringBootApplicationController applicationController =
          applicationContext.getBean(CamelSpringBootApplicationController.class);

        // Block main thread to prevent application from exiting
        applicationController.blockMainThread();
    }
}
