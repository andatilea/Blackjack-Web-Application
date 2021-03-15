module Test.Generated.Main3169272303 exposing (main)

import Tests

import Test.Reporter.Reporter exposing (Report(..))
import Console.Text exposing (UseColor(..))
import Test.Runner.Node
import Test

main : Test.Runner.Node.TestProgram
main =
    [     Test.describe "Tests" [Tests.suite] ]
        |> Test.concat
        |> Test.Runner.Node.run { runs = Nothing, report = JsonReport, seed = 125919723365210, processes = 4, globs = [], paths = ["C:\\Users\\user\\Desktop\\Project_Elm\\tests\\Tests.elm"]}