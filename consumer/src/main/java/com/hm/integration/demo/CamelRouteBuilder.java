package com.hm.integration.demo;

import org.apache.camel.Processor;
import org.apache.camel.Exchange;
import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.*;
import org.apache.camel.LoggingLevel;

@Component
public class CamelRouteBuilder extends RouteBuilder {

  @Value("${name}")
  private String name;

  @Override
  public void configure()
  {
    from("{{camelMqComponent}}:queue:{{queue}}")
      .routeId("Consumer: {{name}}")
      .log("${header.breadcrumbId} Consuming from {{queue}} from producer ${headers.producer}");
  }
}
