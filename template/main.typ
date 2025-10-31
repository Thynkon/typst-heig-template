#import "@local/heig-template:1.0.0": *

#set page(margin: (left: 2cm, top: 1cm, right: 1cm, bottom: 1cm))
#let first_name = "Mário André"
#let last_name = "Rocha Ferreira"
#let author = str(first_name + " " + upper(last_name))

#let practical_work_no = 1
#let subject = "Sécurité Haut Niveau"

#show: project.with(
  title: subject,
  subtitle: "Cheatsheet",
  first_name: first_name,
  last_name: last_name,
  department: "TIC",
  sector: "Informatique et systèmes de communication",
  specialization: "Sécurité informatique",
  locale: "en",
)

