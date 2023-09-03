## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(onetime.dir = tempdir(check = TRUE))
library(onetime)

light_the_candle_with_the_handle <- function () {
  cat("If we kill him with the pill from the till",
      "by making with it the drug in the jug, you need not",
      "light the candle with the handle on the Gateau from the Chateau!",
      sep = "\n")
}

## ---- eval = FALSE------------------------------------------------------------
#  install.packages("onetime")

## ---- eval = FALSE------------------------------------------------------------
#  library(onetime)
#  check_ok_to_store(ask = TRUE)

## -----------------------------------------------------------------------------
id <- "vignette-1"
onetime_message("I shall say this only once!", id = id)

## -----------------------------------------------------------------------------
onetime_message("I shall say this only once!", id = id)

## -----------------------------------------------------------------------------
onetime_message("Does nobody hear the cries of an poor old woman?", id = id)

## -----------------------------------------------------------------------------
id <- "vignette-2"
onetime_message("I repeat... I shall say this only once!", id = id)

## -----------------------------------------------------------------------------
id <- "vignette-3"
onetime_warning("you cannot expect me to shoot everyone in the town. ",
                "I'm unpopular enough as it is!", id = id)

## -----------------------------------------------------------------------------
id <- "vignette-4"
onetime_rlang_inform(c(
                       "Let that be a lesson to you.", 
                       i = "Never again will you burn my toast."
                       ), 
                     id = id)

## -----------------------------------------------------------------------------
id <- "vignette-5"
onetime_do(light_the_candle_with_the_handle(), id = id)

## ---- eval = .Platform$OS.type != "windows"-----------------------------------

# NB: This chunk will only be run on Unix-alikes

cl <- parallel::makeCluster(2, outfile = "check.txt")
otd <- getOption("onetime.dir")

results <- parallel::parSapply(cl, 1:20, otd = otd,
  function (x, otd) {
    options(onetime.dir = otd)
    onetime::onetime_message("I will say this only once!", id = "vignette-6")
  }
)
parallel::stopCluster(cl)

table(results)

readLines("check.txt")

## ---- eval = FALSE------------------------------------------------------------
#  id <- "vignette-7"
#  onetime_message_confirm(
#    "What are you doing with that serving girl in your arms?",
#    id = id)

## ---- echo = FALSE------------------------------------------------------------
message("What are you doing with that serving girl in your arms?")
cat("Show this message again? [yN]")

## -----------------------------------------------------------------------------
id <- "vignette-8"
onetime_message_confirm("One drink and... all is quiet on the Western Front.", 
			id = id)

## -----------------------------------------------------------------------------
id <- "vignette-9"
onetime_message("Good moaning!", 
                id = id, 
                expiry = as.difftime(1, "weeks")
                )

## ---- eval = FALSE------------------------------------------------------------
#  id <- "vignette-10"
#  onetime_message("Thank you for your kind applause.",
#                  id = id,
#                  without_permission = "ask")

## ---- echo = FALSE------------------------------------------------------------
message("The onetime package requests to store files in ",
        "'~/Library/Application Support/onetime'.")
cat("Is this OK? [Yn] ")
message("Thank you for your kind applause.")

## ---- eval = FALSE------------------------------------------------------------
#  check_ok_to_store(
#    ask = TRUE,
#    message = "Please let this package store files in your config directory '%s'.",
#    confirm_prompt = "OK? (Y/N)"
#    )

## ---- echo = FALSE------------------------------------------------------------
message("Please let this package store files in your config directory",
        "'~/Library/Application Support/onetime'")
cat("OK? (Y/N)")

## -----------------------------------------------------------------------------
set_ok_to_store(TRUE)

## ---- eval = FALSE------------------------------------------------------------
#  my_func <- function () {
#    withr::local_options(onetime.dir = "path to preferred directory")
#    onetime_message("Hit it hard with your spoon.",
#                    "They always break in the end.",
#                    id = "flick-1")
#  }

## ---- eval = FALSE------------------------------------------------------------
#  my_func <- function () {
#    oo <- options(onetime.dir = "path to preferred directory")
#    on.exit(options(oo))
#    ...
#  }

## -----------------------------------------------------------------------------
onetime_been_done("vignette-1")
onetime_been_done("vignette-unused")

## -----------------------------------------------------------------------------
onetime_reset(id = "vignette-1")
onetime_message("I shall say this only once!", id = "vignette-1")

## -----------------------------------------------------------------------------
id <- "vignette-11"
onetime_mark_as_done(id)
# Won't be shown:
onetime_message("In my opinion, a whole Meccano set has fallen apart in there.",
	       	id = id)

## ---- include = FALSE---------------------------------------------------------
# Clean up this vignette:
ids <- paste0("vignette-", 1:11)
for (id in ids) onetime_reset(id)
file.remove("check.txt")

