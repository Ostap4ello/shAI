---
title: "ShAI - AI wrapper for shell"
author: "Ostap Pelekh"
geometry: margin=2.5cm
pandoc_:
 - output: build/user-notes.pdf
 - template: codedoc.tex
 - pdf-engine: xelatex
output:
  pdf_document:
    latex_engine: xelatex
    fig_caption: true
---
<!-- nvim-pandoc header -->

\newpage

# 0. Preface

**Expected readership**: developers, DevOps engineers, system administrators, linux enthusiasts.  

**Slovak version of the project proposal:**
```
Zadanie:

Cieľom práce je otestovať využitie lokálnych LLM v kontexte terminálového asistenta. V rámci tejto práce je potrebné navrhnúť a implementovať CLI/TUI asistenta na základe lokálneho LLM, ktorý bude schopný kontextovo-citlivého generovať a dopĺňať príkazy v Linux termináli. Používatelia budú schopní využiť asistenta na zefektívnenie svojej práce v termináli prostredníctvom inteligentných návrhov príkazov a získať odpovede na otázky týkajúce sa najmä terminálu.

Úlohy:

1. Preskúmať a analyzovať existujúce riešenia terminálových asistentov využívajúcich LLM, identifikovať ich silné a slabé stránky, najmä v oblasti kontextovo-citlivého generovania príkazov. Preskúmať možnosti lokálnych LLM.
2. Navrhnúť architektúru terminálového asistenta, vrátane integrácie s vybraným lokálnym LLM, a definovať spôsob získavania kontextu z terminálu (napr. aktuálny adresár, história príkazov, typy súborov).
3. Implementovať CLI/TUI terminálového asistenta podľa navrhnutej architektúry.
4. Vyhodnotiť použiteľnosť navrhnutého riešenia.
```

\newpage

# 1. Introduction

## 1.1 Description and Motivation

ShAI is a wrapper for linux shell, which uses AI to enhance user experience and productivity in terminal environments.

Most solutions nowadays focus on providing AI functionality for terminals as separate applications, IDE plugins, or programs. Also, many of them are either closed-source or complex and not clear enough for being widely adopted. This project tries to solve these issues by being open-source, using another architecture approach and leveraging existing community-driven tools.

## 1.2 User Requirements

The application aims to provide such functionalities:

1. Dangerous command detection/prevention
2. Command autocompletion/suggestion
3. In-terminal AI assistant for help and questions
4. Command history awareness and customizations

5. Seamless integration with existing shell environments (incl. tui programs, where AI functionality should be disabled)
6. Fast and relatively lightweight performance

# 2. Analysis of Existing Solutions

| Tool | Features         | What It Lacks  |
|------|------------------|----------------|
| **Warp**  | WarpAI (terminal-specific, remote)            | Closed-source |
|           | AI chat/autofill                              | **No personalization from local history** |
|           | Command repair                                | macOS-only officially |
|           | Active AI next command & prompt suggestions   | |
|           | Workflows                                     | |
|------|------------------|----------------|
| **gptme** | Multiple LLM support (Online/Offline)  | No error correction |
|           | Capabilities/permissions      | No active/personalized command prediction |
|           | File editing                  | No shell wrapping |
|           | AI chat                       | |
|           | Complex AI command generation | |
|           | Text-to-speech                | |
|------|------------------|----------------|
| **gemini-cli** | Google’s gemini as AI (VertexAI?) | TODO |
|------|------------------|----------------|
| **aiterm**    | Remote LLM        | No command repair/context awareness |
|               | AI chat           | Closed-source / paid |
|               | Workflows         | Limited or no integration with actual shell environments |
|------|------------------|----------------|
| **Yai**   | AI chat/autofill | No filesystem or context awareness |
|           |                  | Lacks predictive capabilities and learning from usage |
|           |                  | Not a full shell |
|------|------------------|----------------|
| **Aider** | File editing                  | Code-oriented, not shell-focused |
|           | AI chat/autofill              | No command error handling |
|           | Complex AI command generation | No interactive CLI prediction |
|           | Workflows                     | |
|------|------------------|----------------|
| **ai-terminal-assistant** | AI chat          | No context or command error awareness |
|                           |                  | Minimal shell integration |
<!-- TODO -->
<!-- |------|------------------|----------------| -->
<!-- | **Claude-Code** | | | -->
<!-- |------|------------------|----------------| -->
<!-- | **cmd-ai** | AI chat/autofill | No learning from history | -->
<!-- |            |                  | No command correction or prediction | -->
<!-- |            |                  | Basic functionality | -->
<!-- |------|------------------|----------------| -->
<!-- | **termai** | see github | | -->
<!-- |------|------------------|----------------| -->
<!-- | **JetBrains AI-in-terminal** | Project-sensitive AI   | IDE-dependent | -->
<!-- |                              | AI chat/autofill       | No shell-specific or real-time command monitoring | -->
<!-- |                              |                        | Not for general Linux terminals | -->
<!-- |------|------------------|----------------| -->


- [Warp terminal](https://www.warp.dev/)

- [gptme](https://github.com/gptme/gptme)

- [gemini-cli](https://github.com/google-gemini/gemini-cli)

- [aiterm](https://www.aiterm.net/)

- [Yai (Your Terminal Assistent)](https://ekkinox.github.io/yai/)

- [Aider](https://aider.chat/)

- [ai-terminal-assistent (github)](https://github.com/boukeversteegh/ai-terminal-assistant)

- [cmd-ai (github)](https://github.com/BrodaNoel/cmd-ai)

- [termai](https://github.com/kyco/termai)

# 3. Prototypes

## 3.1 Prototype 1
The first prototype is a simple proof-of-concept implementation of the shAI idea. It uses a local LLM (Ollama) to distinguish between shell commands and natural language input. If the input is a shell command, it would execute it directly; if it's natural language, it would respond with an answer or suggestion.

### Outcome
While using such architecture is feasible, the problem that arises is how should the wrapper interact with the shell. It cannot attach to an existing bash process, as it is not possible to determine when the shell is waiting for user input (e.g. after running a TUI program) and when it is executing commands (whis will be visible when using TUI applications inside the wrapper).  
Another approach is to create new shell process for each command, but this will lead to loss of context (e.g. current working directory, environment variables, etc.) and will make the wrapper less useful.  

Few more possible approaches to consider are:

1. Implementing the whole shell interpreter (like a mockup) to be able to keep the context and know if the shell is waiting for input or executing commands. This seems to be complex and not very maintainable afterwards.
2. Read on features of existing shells (e.g. zsh, fish, bash) to see if they provide any hooks or APIs to interact with the shell process.
    - [bash ref manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Controlling-the-Prompt)
    - zsh - [oh my zsh plugins](https://ohmyz.sh/)
    - fish shell - plugins - is not POSIX compliant, so not very useful for wider audience
    - [GNU readline, hooks](https://tiswww.case.edu/php/chet/readline/rltop.html), [HSTR](https://github.com/dvorka/hstr)
    - [athame](https://github.com/ardagnir/athame) - another bash wrapper, that uses vim process to scan the current screen and basically acts as a buffer for the whole terminal. Could be an interesting approach to explore. (read code again :) )


Read on:

- [SHELLGPT](https://ieeexplore.ieee.org/abstract/document/10301251) - paper on specialized LLM for shell commands based on GPT-2
    also: use this article to find more related works, especially to define base info.
- experimenting on proto-1
- put theory to bachelor's
- [Agents](https://medium.com/@Shamimw/using-ai-agents-to-execute-shell-scripts-with-langgraph-using-ollama-a-smarter-approach-to-679fd3454b09)
- This work can be used or compared with as detecting dangerous commands is one of the features:
    - [CLI Risc classification using transformers](https://arxiv.org/html/2412.01655v1)


# 4. Ideas

- simple shell emulator, which, subsequently, calls bash
- bash plugin - shell plugins

Other ideas:

- Use OpenAI one shot training / few shot training / chain of thought to fine-tune a model to meet the specific needs of the application.
- Use a local LLM (e.g. llama) to provide offline functionality and reduce the need for internet access.
- Combine online and offline models.
