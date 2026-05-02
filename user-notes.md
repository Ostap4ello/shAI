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

\newpage <!-- --- -->
### future-todo

- features / func:
    - Dangerous command detection/prevention
    - Command autocompletion/suggestion
    - In-terminal AI assistant for help and questions
    - Command history awareness and customizations
    - Seamless integration with existing shell environments (incl. tui programs, where AI functionality should be disabled)
    - Fast and relatively lightweight performance
    - Combine online and offline models.
- Use OpenAI one shot training / few shot training / chain of thought to fine-tune a model to meet the specific needs of the application.
- bash plugin - shell plugins
- ? XAI - ecplainable AIng transformers](https://arxiv.org/html/2412.01655v1)
- This work can be used or compared with as detecting dangerous commands is one of the features:
    - [CLI Risc classification usi- User stories / Use cases / Examples (what it does in particular)
- ? fine-tuning and custom models? \subsubsection{Fine-tuning and Custom Models}

\newpage <!-- --- -->
### todo

- Read on features of existing shells (e.g. zsh, fish, bash) to see if they provide any hooks or APIs to interact with the shell process. (Implementing the whole shell interpreter (like a mockup) to be able to keep the context and know if the shell is waiting for input or executing commands. This seems to be complex and not very maintainable afterwards.)
    - [bash ref manual](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Controlling-the-Prompt)
    - zsh - [oh my zsh plugins](https://ohmyz.sh/)
    - fish shell - plugins - is not POSIX compliant, so not very useful for wider audience
    - [GNU readline, hooks](https://tiswww.case.edu/php/chet/readline/rltop.html), [HSTR](https://github.com/dvorka/hstr)
    - [athame](https://github.com/ardagnir/athame) - another bash wrapper, that uses vim process to scan the current screen and basically acts as a buffer for the whole terminal. Could be an interesting approach to explore. (read code again :) )
- [SHELLGPT](https://ieeexplore.ieee.org/abstract/document/10301251) - paper on specialized LLM for shell commands based on GPT-2
    also: use this article to find more related works, especially to define base info.
- [Agents](https://medium.com/@Shamimw/using-ai-agents-to-execute-shell-scripts-with-langgraph-using-ollama-a-smarter-approach-to-679fd3454b09)

- Test Pipeline Using cloud LLM

- add this info to bachelor:
    - UML, functional requirements, -- sw def
    - Expected behavior / look
    - users query types
        1. fact
        2. info from multiple points in database
        3. action
        4. action with hidden context (need to retrieve info)

- qualitative testing
- trying different models
- put diagrams in pdf instad of png (png = ba d  resolution)
- appenix with mention of gh, user quide, docs


\newpage <!-- --- -->
### to-sort

#### bachelor thesis topic history
note each step was made becouse there have already been some works in the field,
and I had to find something that is not already done, but also not too complex
to be done in the time frame of bt

1. main idea - ai used in shell, relying on external llm (with features like
   command autocompletion, suggestions, in-terminal assistant, dangerous command
   detection/prevention, etc.) -- solutions existed
2. idea ai wrapper for shell. focus on seamless integration, context awareness
   -- solutions existed, hard to test
3. idea - ai wrapper for shell, with focus on context awareness and seamless
   integration, but also with focus on detecting dangerous commands and
   preventing them from being executed. -- some solutions, but hard to test
4. idea - local ai wrapper for shell, with focus on context awareness and seamless
   integration, but also with focus on detecting dangerous commands and
   preventing them from being executed. -- during initial testing, found out
   local ais to be not good for the task, pous the features were to broad, so
   decided to narrow down the scope to assistant features
5. 3 modules - classifier, agent, rag - architecture for ths system, bit more
   realistic, but still hard to test, and also the features were still to broad
6. main focus on rag system using embedding local llms, as modules 1, 3 were to
   hard for local llmas to function


<!-- % \subsubsection{System Requirements} -->
<!-- % -->
<!-- % The application is designed to operate on modern Linux-based systems with -->
<!-- % reasonable computational capabilities. The following system requirements ensure -->
<!-- % reliable operation and acceptable performance: -->
<!-- % -->
<!-- % \paragraph{Operating Systems} -->
<!-- % The application is officially supported and tested on the following Linux distributions -->
<!-- % (versions released after 2024): -->
<!-- % \begin{itemize} -->
<!-- %   \item Arch Linux (and derivatives) -->
<!-- %   \item Debian 12+ (Bookworm or newer) -->
<!-- %   \item Ubuntu 22.04 LTS and newer -->
<!-- %   \item Fedora 38+ -->
<!-- % \end{itemize} -->
<!-- % -->
<!-- % \paragraph{Hardware Specifications} -->
<!-- % -->
<!-- % \begin{table} -->
<!-- %   \centering -->
<!-- %   \small -->
<!-- %   \caption{Minimum and recommended hardware specifications} -->
<!-- %   \label{tab:hardware-specs} -->
<!-- %   \begin{tabularx}{\textwidth}{|l|X|X|} -->
<!-- %     \toprule -->
<!-- %     \textbf{Component} & \textbf{Minimum} & \textbf{Recommended} \\ -->
<!-- %     \midrule -->
<!-- %     \textbf{RAM} & 4 GiB & 8 GiB or more \\ -->
<!-- %     \midrule -->
<!-- %     \textbf{CPU} & Intel i5 (5th gen) or AMD Ryzen 5 (1st gen) & Intel i7/i9 (7th gen+) or AMD Ryzen 7/9 (3rd gen+) \\ -->
<!-- %     \midrule -->
<!-- %     \textbf{Disk Space} & 5 GiB (for application + models) & 10 GiB (for application, models, and document database) \\ -->
<!-- %     \midrule -->
<!-- %     \textbf{GPU} & Optional (CPU fallback supported) & NVIDIA/AMD GPU with 2+ GiB VRAM for accelerated inference \\ -->
<!-- %     \bottomrule -->
<!-- %   \end{tabularx} -->
<!-- % \end{table} -->
<!-- % -->
<!-- % \paragraph{Software Dependencies} -->
<!-- % \begin{itemize} -->
<!-- %   \item Python 3.10 or newer -->
<!-- %   \item Docker (for containerized Ollama deployment) -->
<!-- %   \item Standard Unix utilities (bash, grep, sed, etc.) -->
<!-- %   \item libssl-dev or equivalent for cryptographic operations -->
<!-- % \end{itemize} -->
<!-- % -->
<!-- % \paragraph{Storage and Database Requirements} -->
<!-- % \begin{itemize} -->
<!-- %   \item Minimum document collection size: 10 files of \textasciitilde{}50 KiB each -->
<!-- %   \item Maximum tested document collection: 200+ files of varying sizes -->
<!-- %   \item Average embedding index overhead: \textasciitilde{}20-30\% of original document size -->
<!-- % \end{itemize} -->
<!-- % -->
<!-- % \paragraph{Network Requirements} -->
<!-- % \begin{itemize} -->
<!-- %   \item No internet connection required for runtime operation (fully offline) -->
<!-- %   \item Internet required only for initial installation and model downloads -->
<!-- % \end{itemize} -->

<!-- % \paragraph{Embedding Models and Technology Stack.}{} -->
<!-- % -->
<!-- % The DB module uses the following technologies: -->
<!-- % -->
<!-- % \begin{itemize} -->
<!-- %   \item \textbf{Embedding models:} Four local embedding models are supported: -->
<!-- %     \begin{itemize} -->
<!-- %       \item \texttt{Qwen3-Embedding-0.6B} --- 0.6B parameters, 32K context, supports user-defined dimensions -->
<!-- %       \item \texttt{EmbeddingGemma-300M} (Google) --- 300M parameters, 2048 context, 768 dimensions -->
<!-- %       \item \texttt{granite-embedding-30m-english} --- 30M parameters, 512 context, English-only -->
<!-- %       \item \texttt{granite-embedding-278m-multilingual} --- 278M parameters, 512 context, multilingual (12 languages) -->
<!-- %     \end{itemize} -->
<!-- %     All models are run locally via Ollama and can be configured at index build time. The choice of -->
<!-- %     embedding model affects both index quality and inference latency, allowing trade-offs between -->
<!-- %     model size and representation capacity. -->
<!-- % -->
<!-- %   \item \textbf{Vector database:} FAISS (Facebook AI Similarity Search) is used for indexing -->
<!-- %     and searching embeddings. FAISS provides fast approximate nearest neighbor search and -->
<!-- %     supports multiple similarity metrics (cosine similarity, inner product, Euclidean distance). -->
<!-- %     The vector index is persisted to the file system for reuse across runs. -->
<!-- % -->
<!-- %   \item \textbf{LLM models for generation:} The system supports multiple language models via Ollama: -->
<!-- %     \begin{itemize} -->
<!-- %       \item \texttt{Qwen2.5-0.5B-Instruct} --- 0.5B, 32K context (up to 128K; 8K generation) -->
<!-- %       \item \texttt{Qwen2.5-1.5B-Instruct} --- 1.5B, 32K context (up to 128K; 8K generation) -->
<!-- %       \item \texttt{Qwen3-0.6B} --- 0.6B, 32K context -->
<!-- %       \item \texttt{Qwen3-1.7B} --- 1.7B, 32K context -->
<!-- %       \item \texttt{Granite-3.1-1B-A400M-Instruct} (MoE) --- 1.3B (400M active), 128K context -->
<!-- %       \item \texttt{Gemma 3 (Google)} --- 4B, 32K context -->
<!-- %     \end{itemize} -->
<!-- %     The specific model used can be configured via the configuration module. Smaller models -->
<!-- %     (0.5B-1.7B) are preferred for lower latency on consumer hardware, while larger models -->
<!-- %     (4B) may provide better answer quality at the cost of increased inference time. -->
<!-- % -->
<!-- %   \item \textbf{Connection to LLM:} The OpenAI API client connects to local Ollama instances -->
<!-- %     for both embedding generation and text generation. The same infrastructure is used by -->
<!-- %     the RAG module for answer generation once relevant passages have been retrieved. -->
<!-- % \end{itemize} -->
<!-- % -->
<!-- % \paragraph{NOTE} -->
<!-- % The task of this module is, provided with a path to a folder with resources -->
<!-- % (man pages, in our case), assuming that each document in it can be assigned one -->
<!-- % topic, to (1) search the data and return top-k document identifiers (file -->
<!-- % paths). It will use a locally run embedding model to (2) index these documents -->
<!-- % and enable contextual search.\\ -->
<!-- % -->
<!-- % The interface it should provide will consist of mainly three functions: -->
<!-- % -->
<!-- % \begin{enumerate} -->
<!-- %   \item \texttt{build (db\_path, index\_path\_within\_db, -->
<!-- %     OpenAIAPI-Client, model)} --- will build -->
<!-- %     an index at the specified \texttt{db\_path}, and save it, along -->
<!-- %     with the model used for -->
<!-- %     embedding creation (as \texttt{config.json}) into -->
<!-- %     \texttt{db\_path/index\_path\_within\_db}. -->
<!-- %     \texttt{index\_path\_within\_db} is a non-mandatory parameter, -->
<!-- %     and its default value is -->
<!-- %     \texttt{.index}. For creating embeddings, it will use -->
<!-- %     \texttt{OpenAIAPI-Client} with the specified model. -->
<!-- % -->
<!-- %   \item \texttt{check (db\_path, index\_path\_within\_db)} --- will -->
<!-- %     check the availability of the index -->
<!-- %     within \texttt{db\_path}. -->
<!-- % -->
<!-- %   \item \texttt{search (db\_path, index\_path\_within\_db, -->
<!-- %     OpenAIAPI-Client)} --- will conduct a search -->
<!-- %     on \texttt{db\_path}, using the index from -->
<!-- %     \texttt{db\_path/index\_path\_within\_db}, with -->
<!-- %     \texttt{OpenAIAPI-Client} and the model from -->
<!-- %     \texttt{db\_path/index\_path\_within\_db}. Calls -->
<!-- %     \texttt{check (db\_path, index\_path\_within\_db)} --- will check -->
<!-- %     the availability of the index -->
<!-- %     within \texttt{db\_path} and \texttt{index\_path\_within\_db}.\\ -->
<!-- % \end{enumerate} -->
<!-- % -->
<!-- % It should also implement its own CLI interface with \texttt{build} and -->
<!-- % \texttt{search} commands for testing purposes. -->
<!-- % -->
<!-- % This implementation will be using following technologies: -->
<!-- % \begin{itemize} -->
<!-- %   \item \textbf{Embedding model}: We will be choosing a local -->
<!-- %     embedding model from: -->
<!-- %     \begin{itemize} -->
<!-- %       \item \texttt{qwen3-embedding:0.6b} -->
<!-- %       \item \texttt{ibm/granite-embedding:125m} -->
<!-- %     \end{itemize} -->
<!-- %   \item \textbf{Vector database}: We will be using \texttt{FAISS} for -->
<!-- %     indexing and searching the embeddings. We will test different -->
<!-- %     similarity metrics (e.g.~cosine similarity, inner product) to find the -->
<!-- %     best one for our use case. -->
<!-- %   \item \textbf{Connection to \gls{llm}}: We will be using -->
<!-- %     \texttt{OpenAIAPI-Client} to connect to the local -->
<!-- %     \gls{llm} for generating responses based on the retrieved information. -->
<!-- % \end{itemize} -->
<!---->
<!-- % \paragraph{RAG implementation and information extraction by \gls{llm}.}{} -->
<!-- % -->
<!-- % The naive approach to RAG implementation would be to retrieve the top-k -->
<!-- % relevant documents and pass them all to the \gls{llm} in one prompt. However, this -->
<!-- % approach generates great overhead in terms of prompt size, -->
<!-- % negatively affecting performance, precision, and latency of small -->
<!-- % \glspl{llm}. -->
<!-- % -->
<!-- % To minimize RAG-induced overhead, an additional step was implemented -->
<!-- % where the \gls{llm} selects the most relevant documents based on their -->
<!-- % beginnings (e.g., command names and short descriptions in man pages). -->
<!-- % This pre-filtering process is designed to improve accuracy and reduce -->
<!-- % the computational load, ensuring that only essential information is processed. -->
<!-- % -->
<!-- % Another optimization strategy is to process the retrieved documents in smaller, -->
<!-- % manageable parts rather than in full. This can be implemented in two ways: -->
<!-- % first, where the \gls{llm} processes one document at a time and aggregates results, -->
<!-- % or second, where, before passing the documents to the \gls{llm}, they are split into -->
<!-- % smaller parts (e.g., sections or paragraphs) and filtered by the embedding -->
<!-- % model for relevance. The second approach is more efficient as it reduces the -->
<!-- % number of interactions with the \gls{llm}, thus minimizing latency and improving -->
<!-- % precision. -->
<!---->
