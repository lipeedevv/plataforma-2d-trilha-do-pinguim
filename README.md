# Trilha do Pinguim

Jogo de plataforma 2D em Godot, desenvolvido por Felipe e Iasmim para a Avaliação de Jogos.

## Como jogar

1. Abra o Gerenciador de Projetos do Godot 4.7.2 e importe o arquivo `project.godot`.
2. Pressione **F5** e clique em **Jogar**.
3. Use **←** e **→** para andar e **Espaço** para pular. Pressione **Espaço** novamente no ar para dar um pulo duplo.
4. Colete as seis moedas e siga até a saída. Desvie dos esqueletos e dos buracos. O coração recupera uma vida.

## Estrutura

| Caminho | Conteúdo |
| --- | --- |
| `project.godot` | Configuração e ponto de entrada do jogo. |
| `scenes/forest.tscn` | Fase principal, com terreno, inimigos, itens e saída. |
| `scenes/` | Cenas do jogador, dos inimigos, dos itens e da interface. A cena `main.tscn` é a base do exercício. |
| `scripts/` | Movimento, colisões, vidas, coleta, HUD e fluxo da partida. |
| `sprites/` e `tiles/` | Imagens dos personagens, itens, cenário e terreno. |
| `audio/` | Música da floresta e efeitos sonoros originais do projeto. |

Os arquivos `.uid` e `.import` acompanham os recursos. O Godot recria o cache `.godot/` na primeira importação.
