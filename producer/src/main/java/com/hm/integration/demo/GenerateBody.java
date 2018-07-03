package com.hm.integration.demo;

import org.apache.camel.Processor;
import org.apache.camel.Exchange;
import org.apache.camel.builder.RouteBuilder;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.*;
import org.apache.camel.LoggingLevel;

public class GenerateBody implements Processor {

  /*
   * Injecting property from OS environment variable
   */
  @Value("${size}")
  private int size;

  private String body;

  public GenerateBody()
  {
    body = generate(size);
  }

  private String generate(int len)
  {
    StringBuilder sb = new StringBuilder();
    for( int i = 0; i < len; i++ ) {
      sb.append("a");
    }
    return sb.toString();
  }

  public void process(Exchange ex)
  {
    ex.getIn().setBody(body);
  }

}
