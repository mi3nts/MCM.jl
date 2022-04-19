using MCM
using Documenter

DocMeta.setdocmeta!(MCM, :DocTestSetup, :(using MCM); recursive=true)

makedocs(;
    modules=[MCM],
    authors="John Waczak <john.louis.waczak@gmail.com>",
    repo="https://github.com/mi3nts/MCM.jl/blob/{commit}{path}#{line}",
    sitename="MCM.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mi3nts.github.io/MCM.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mi3nts/MCM.jl",
    devbranch="main",
)
