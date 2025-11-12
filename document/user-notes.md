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

**Version history**:

| Version | Date       | Author        | Description               |
|---------|------------|---------------|---------------------------|
| 0.1     | 2025-11-02 | Ostap Pelekh  | Initial draft             |

\newpage

# 1. Introduction

## 1.1 Description and Motivation

ShAI is a wrapper for linux shell, which uses AI to enhance user experience and productivity in terminal environments.

Most solutions nowadays focus on providing AI functionality for terminals as separate applications, IDE plugins, or programs. Also, many of them are either closed-source or complex and not clear enough for being widely adopted. This project tries to solve these issues by being open-source, using another architecture approach and leveraging existing community-driven tools.

# 1.2 User Requirements

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

### Ideas:

- simple shell emulator, which, subsequently, calls bash
- bash plugin - shell plugins

Other ideas:

- Use OpenAI one shot training / few shot training / chain of thought to fine-tune a model to meet the specific needs of the application.
- Use a local LLM (e.g. llama) to provide offline functionality and reduce the need for internet access.
- Combine online and offline models.
