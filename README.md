ramora: Quick Start Research Project
================

![](inst/header_logo.png)

Running below code your project root directory. Then the rstudio server
which mounted the local project directory will start up
(`localhost:8787`).

``` bash
docker pull uribo/ramora
```

`docker run -e PASSWORD=<PASSWORD> -p 8787:8787 uribo/ramora`

## Session Info

![R](https://img.shields.io/badge/R-4.0.3-brightgreen)
![CRAN/METACRAN](https://img.shields.io/cran/v/renv)

## System Components

-   ✔️ Ansible
-   ✔️ RStudio Server
    -   including `tidyverse`, `sf` etc.
-   ✔️ pandoc
-   ✔️ LaTeX environment
    -   Available Japanese PDF Output 🇯🇵

## R Packages 📦

### ♻️ Reproducibility

-   drake
-   reprex

### 💾 Collect Data

-   rdrop2

### 💡 EDA

-   assertr
-   ensurer
-   naniar
-   skimr

### 📈 Visualization

-   cowplot
-   ggforce
-   hrbrthemes
-   patchwork
-   colormap
-   cptcity
-   scico

### 📝 Writing Process Enhancement

-   rmarkdown
-   knitr

### ⚙️ Others

-   bench
-   config
-   conflicted
-   here
-   usethis
-   whoami
-   tictoc

## How to build

``` bash
cd ramora/
docker build -t <user_name/image_name> .
docker login
docker push <user_name/image_name:tag>
```

## Ansible

``` bash
ansible-galaxy install yutannihilation.module-cran

ansible-playbook -i hosts ansible/localhost.yaml
```
