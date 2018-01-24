ramora: Quick Start Research Project
================

![](inst/header_logo.png)

Running below code your project root directory. Then the rstudio server which mounted the local project directory will start up (`localhost:8787`).

``` r
devtools::source_gist(id       = "56853ecab8533e033fccb35b2b6e0154",
                      filename = "docker_container.R")
rss_instance <- docker_quick_start(image   = "uribo/ramora",
                                   remove  = TRUE,
                                   detach  = FALSE)
```

This is the same process as the following code.

``` r
image <- "uribo/ramora"

docker::docker$from_env()
rprojroot::find_rstudio_root_file()
container_name <- basename(project_path)
  
mount <- list(list("bind" = paste0("/home/rstudio/", container_name),
                     "mode" = "rw"))
names(mount) <- project_path
  
rss_instance <- client$containers$run(image       = image,
                                      volumes     = mount,
                                      name        = container_name,
                                      environment = list("ROOT" = "TRUE"),
                                      ports       = list("8787/tcp" = "8787"),
                                      remove      = TRUE,
                                      detach      = FALSE)
  
rss_instance$start()
# stop process
# rss_instance$stop()
```

System Components
-----------------

-   ✔️ Ansible
-   ✔️ RStudio Server
    -   including `tidyverse`, `sf` etc.
-   ✔️ pandoc
-   ✔️ LaTeX environment
    -   Available Japanese PDF Output 🇯🇵

R Packages 📦
------------

### 👜 Portability

-   docker

### ♻️ Reproducibility

-   liftr
-   here
-   (remake)

### 💾 Collect Data

-   estatapi
-   rdrop2
-   jpmesh

### 📈 Visualization

-   ggforce
-   hrbrthemes

### 📝 Writing Process Enhancement

-   RefManageR

### ⚙️ Others

-   config
-   caTools
-   jpndistrict
