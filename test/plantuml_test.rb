# frozen_string_literal: true

require "test_helper"

class BookLab::PlantumlTest < ActiveSupport::TestCase
  test "encode" do
    code = <<~CODE
    @startuml

    title Activity Diagram

    start

    :Eat Hot Wings;

    note left
        This is a Note...
    end note

    :Drink Homebrew;

    stop

    @enduml
    CODE

    url_code = "U9mTZJiE0Z4GGtkVOawG0x3D8YqI5HKITO1X6P4FIWo8spF1ScKzstDdR7pb1D2OLBONsjlubSNYsc86_WImsKNAlb9ELjO-0QLI9UcD4DVnRbtSKGwUXn2WvIg3yUhIh3oydFNSz3EDpVe4PaV6zGzt8Ygl"
    assert_equal url_code, BookLab::Plantuml.encode(code)

    code = <<~CODE
    @startuml

    title Relationships - Class Diagram


    class Dwelling {
      +Int Windows
      +void LockTheDoor()
    }

    class Apartment
    class House
    class Commune
    class Window
    class Door

    Dwelling <|-down- Apartment: Inheritance
    Dwelling <|-down- Commune: Inheritance
    Dwelling <|-down- House: Inheritance
    Dwelling "1" *-up- "many" Window: Composition
    Dwelling "1" *-up- "many" Door: Composition

    @enduml
    CODE

    url_code = "U9o5aC6AmZ0GXk_p54DFwfA3L_6Ww471amYUGplOOPEPqgIAgEzkewtBWkxUyfCltp-PMOYsZert096Z8zoIiv5LGibLG8CBPqF09Tj3RJq0vCzy8kTO3dW1nA-rHDop57eAAHwL2zne_hqhQQbQ3uPmwn_EgxREayGkhxG9r9qNwdqZVNeA-xvM0_1gdLvDUoVcHpV1jPHKSxIIqnkmS_-7FSRv06NZ34UcgGnctievwoQS97UbWTFM_g3J5twpC2CfqkhleK64Q000"
    assert_equal url_code, BookLab::Plantuml.encode(code)
  end
end
