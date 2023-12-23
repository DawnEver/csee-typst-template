#let font_2p = 22pt
#let font_3p = 16pt// 16pt对应的是三号字体
#let font_s3p = 15pt
#let font_4p = 14pt
#let font_s4p = 12pt
#let font_5p = 10.5pt
#let font_s5p = 9pt

#let font_hei = "Hei"
#let font_sun = "Songti SC"
#let font_times = "Times"
#let font_arial = "Arial"
#let font_kai = "Kai"
#let font_fsun = "STFangsong"
#let font_body = ("Times","Songti SC")
#let font_title = ("Arial","Hei")
#let font_def = ("Times","Hei")

#let project(
  title: "",
  authors: (),
  address: "",
  title_cn: "",
  authors_cn: (),
  address_cn: "",
  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,
  abstract_cn: none,
  // A list of index terms or keywords to display after the abstract.
  keywords:(),
  keywords_cn:(),
  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,
  // The paper's content.
  body
) = {
  // Set document metdata.
  set document(title: title_cn, author: authors_cn)

  
  // Configure the page.
  set page(
    paper: "a4",
    // The margins depend on the paper size.
    margin: (left:2.0cm, right:2.0cm, top: 3.2cm, bottom: 2.5cm),
    header: locate(loc => {

      let page_counter = counter(page)
      let page_number = page_counter.at(loc).first()
      if page_number==1 [
        #align(center)[
          #text(font:font_body,size:font_s5p,)[中#h(0.4cm)国#h(0.4cm)电#h(0.4cm)机#h(0.4cm)工#h(0.4cm)程#h(0.4cm)学#h(0.4cm)报\ Proceedings of the CSEE]
        ]
      ]else if calc.odd(page_number) [
        #v(-5pt, weak: true)      
        #align(right)[
          #page_number
        ]
      ]else[
        #align(center)[
          #text(font:font_body,size:font_s5p,)[中#h(0.4cm)国#h(0.4cm)电#h(0.4cm)机#h(0.4cm)工#h(0.4cm)程#h(0.4cm)学#h(0.4cm)报]
        ]
        #v(-5pt, weak: true)      
        #page_number
      ]
      v(5pt, weak: true)
      line(length: 100%,stroke: 0.5pt)
      v(1.3pt, weak: true)
      line(length: 100%,stroke: 0.5pt)
    }),
      

  )
  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)",supplement:[])
  show math.equation: set block(spacing: 0.65em)

  // Configure figures and tables.
  set figure(supplement:[])
  show figure: it => {
    set text(font: font_body,weight: "black",size:font_s5p)
    set align(center)
    if it.kind == image [
      #box[
        #it.body
        #v(10pt, weak: true)
        图 #it.caption//\
        // Fig #it.caption
      ]
    ] else if it.kind == table [
      #box[
        表#it.caption//\
        // Tab.#it.caption
        #v(10pt, weak: true)
        #it.body
      ]
    ] else [
      ...
    ]
}
  set table(stroke: 0.5pt,)
  show table: set text(8pt)
  
  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.

  set heading(numbering: "1.")
  show heading: it =>  {
    if it.level == 1 [
      #if it.body == "致谢" [
      ]else if it.body == "参考文献" [
        #text(font:font_title,size:font_s4p)[#it.body]
      ]else[
        // #text(font:font_title,size:font_s4p)[
        //   #counter(heading).display()#h(6pt)#it.body]
        #text(font:font_title,size:font_s4p)[#it]
      ]
    ] else if it.level == 2 [
      // #text(font:font_title,size:font_5p)[
      //   #counter(heading).display()#h(6pt)#it.body]
      #text(font:font_title,size:font_5p)[#it]
    ] else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 [
        // #text(font:font_body,size:font_5p)[
        //   #counter(heading).display()#h(6pt)#it.body]
        #text(font:font_body,size:font_5p)[#it]
      ]
    ]
    text()[#v(0.1em, weak: true)];text()[#h(0em)]
  }
  // ==================================================
  // Display the paper's title.
  set text(fallback: false)
  align(center)[
  #text(title_cn, size: font_2p,font:font_title)
  #v(font_4p, weak: true)
  #text(authors_cn.join("，"), size: font_4p,font:font_fsun)
  #v(font_4p, weak: true)
  #text("（"+address_cn+"）", size: font_5p,font:font_kai)
  #v(2*font_5p, weak: true)
  #text(title, size: font_s4p,font:font_times, weight: "black")
  #v(font_5p, weak: true)
  #text(authors.join(", "), size: font_5p,font:font_times)
  #v(font_5p, weak: true)
  (#text(address, size: font_5p,font:font_times))
  ]

  // Start two column mode and configure paragraph properties.
  show: columns.with(2, gutter: 12pt)
  set par(justify: true)
  // Display abstract , index terms or keywords.
  set text(size: font_s5p,font: font_body)
  set par(leading: font_s5p)
  if abstract != none [  
    *ABSTRACT:* #abstract
    
    #if keywords != () [
    *KEY WORDS:* #keywords.join(", ")
    
    ]
  ]
  if abstract_cn != none [
    *#text(font:font_hei)[摘要]:* #abstract_cn

    #if keywords_cn != () [
    *#text(font:font_hei)[关键字]:* #keywords_cn.join(", ")

    ] 
  ]

  // Display the paper's contents.
  set par(justify: true, first-line-indent: 0.74cm)
  set text(font_5p,font:font_body) //会自动匹配前面的是英语字体，后面的是中文字体
  body
  // v(font_4p, weak: true) 

  // Display bibliography.
    if bibliography-file != none {
      
      show bibliography: set text(size:font_5p,font:font_body)
      
      bibliography(bibliography-file, title: text(size:font_s4p,font:font_hei)[参考文献], style: "gb-7714-2015-numeric")
      // bibliography(bibliography-file, title:"参考文献", style: "gb-7714-2015-numeric")
    }

}
