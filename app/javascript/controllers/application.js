import { Application } from "@hotwired/stimulus"

import HelloController from "./hello_controller"

window.Stimulus = Application.start()
Stimulus.register("hello", HelloController)
