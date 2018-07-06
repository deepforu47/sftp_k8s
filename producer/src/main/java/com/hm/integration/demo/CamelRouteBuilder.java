package com.hm.integration.demo;

import org.apache.camel.Processor;
import org.apache.camel.Exchange;
import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.*;
import org.apache.camel.LoggingLevel;

@Component
public class CamelRouteBuilder extends RouteBuilder {

  @Value("${size}")
  private int size;

  /**
   * Generates a random string of size len
   *
   * Uses the captial characters A to Z (ascii codes 65 to 90)
   *
   * @param len Length of the String to Generates
   * @return The generated String
   */
  private String generate(int len)
  {
    StringBuilder sb = new StringBuilder();
    for( int i = 0; i < len; i++ ) {
      char c = (char) (65 + 25*Math.random());
      sb.append(c);
    }
    return sb.toString();
  }

  @Override
  public void configure()
  {
    from("timer://foo?fixedRate=true&period={{rate}}&repeatCount={{repeatCount}}")
      .routeId("Producer: {{name}}")
      .setHeader("producer", simple("{{name}}"))
      .setBody(constant(generate(size)))
      .log("${header.breadcrumbId} sending to {{queue}} with size {{size}}")
      .to("{{camelMqComponent}}:queue:{{queue}}")
      .log("${header.breadcrumbId} sent to {{queue}} with size {{size}}");
  }
}
