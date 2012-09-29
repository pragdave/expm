defmodule Expm.Server.Templates do
  require EEx

  EEx.function_from_string :def, :list,
    %b{
          <h1>Index</h1>
          <ul>
           <%= lc pkg inlist pkgs do %>
             <li><a href="<%= pkg.name %>"><%= pkg.name %></a> <%= pkg.description %></li>
           <% end %>
          </ul>
      }, [:pkgs]

  EEx.function_from_string :def, :package,
    %b{
     <ul class="breadcrumb">
       <li><a href="/">Home</a> <span class="divider">/</span></li>
       <li><a href="/<%= package.name %>"><%= package.name %></a> <span class="divider">/</span></li>
       <li class="active"><%= package.version %></li>
     </ul>
     <h1> <%= package.name %> (<%= package.version %>) </h1>
     <h4> <%= package.description %> </h4>
     <table class="table table-bordered table-striped">
      <thead>
      <tr>
        <th>Field</th>
        <th>Value</th>
      </tr>
      </thead>
      <tbody>
      <%= lc \{field, value\} inlist package.to_keywords do %>
         <tr>
           <td><b><%= to_binary field %></b></td>
           <td><%= inspect value %></td>
         </tr>
      <% end %>
      </tbody>
     </table>
     <h4>package.exs:</h4>
     <pre><%= inspect package %></pre>
    },[:package]

  EEx.function_from_string :def, :page,
    %b{

      <!DOCTYPE html>
      <html>
        <head>
          <title>EXPM</title>
          <!-- Bootstrap -->
          <link href="/s/css/bootstrap.min.css" rel="stylesheet">
        </head>
        <body>

         <div class="navbar navbar-inverse navbar-fixed-top">
              <div class="navbar-inner">
                <div class="container">
                  <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                  </a>
                  <a class="brand" href="/">EXPM</a>
                  <div class="nav-collapse collapse">
                    <ul class="nav">
                    </ul>
                  </div><!--/.nav-collapse -->
                </div>
              </div>
            </div>        
            <a href="https://github.com/yrashk/expm"><img style="position: absolute; top: 0; right: 0; border: 0; z-index: 999999999" src="https://s3.amazonaws.com/github/ribbons/forkme_right_orange_ff7600.png" alt="Fork me on GitHub"></a>
            <p><%= @motd %></p>

            <div class="container">
              <div class="well hero-unit">
                <h1>Elixir Package Manager</h1>
                <p>
                  <%= @motd %>
                </p>
              </div>
              <div class="row">
                <%= content %>
              </div>
              <hr>

              <div class="row well" style="margin-top: 40px">
                <p>This repository is available over HTTP:</p>
                   
                <p>
                  <code>repo = Expm.Repository.HTTP.new url: "http://<%= @host %><%= @port %>"[, username: "...", password: "..."]</code>
                </p>
                <p>To publish a package:</p>

                <code>Expm.Package.publish repo, Expm.Package.read(filename // "package.exs") </code>
              </div>
            </div>


          <script src="http://code.jquery.com/jquery-latest.js"></script>
          <script src="/s/js/bootstrap.min.js"></script>
        </body>
      </html>
    }, [:content, :assigns]


  
end