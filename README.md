# ChamberEvoker

<p align="center">
  <strong>Um mago. Uma câmara. Uma sequência de salas.</strong>
</p>

ChamberEvoker é um jogo 2D de puzzles e plataforma desenvolvido com **Godot Engine 4.7**, no qual o jogador controla um mago que precisa explorar uma misteriosa câmara, solucionar desafios e encontrar o caminho para avançar.

Para superar os obstáculos, o jogador utiliza diferentes invocações mágicas, criando objetos que modificam o ambiente e permitem alcançar lugares antes inacessíveis.

Cada desafio exige observação, planejamento e gerenciamento dos recursos disponíveis.

---

## Sobre o jogo

Preso em uma enorme câmara repleta de obstáculos e mecanismos, o protagonista precisa utilizar suas habilidades de invocação para encontrar uma saída.

Pontes, cordas e paredes são algumas das ferramentas disponíveis. Cada objeto possui uma finalidade específica, e sua utilização exige atenção ao posicionamento e aos recursos disponíveis.

O ambiente é formado por diferentes salas e desafios, nos quais o jogador precisa descobrir como utilizar suas habilidades para avançar.

**O objetivo é resolver os puzzles, administrar a mana e alcançar a saída de cada câmara.**

## Mecânicas principais

### Invocação de objetos

O jogador pode selecionar e posicionar diferentes objetos mágicos para interagir com o cenário.

| Objeto | Funcionalidade |
|---|---|
| Ponte | Conecta plataformas e permite atravessar vãos. |
| Corda | Cria pontos de sustentação para alcançar diferentes alturas. |
| Parede | Bloqueia caminhos e permite modificar a passagem pelos obstáculos. |

### Gerenciamento de mana

Cada invocação possui um custo de mana. O jogador precisa administrar seus recursos para conseguir concluir os desafios.

A quantidade de mana disponível e o custo dos objetos podem variar de acordo com a fase.

### Puzzles e exploração

- Obstáculos que exigem diferentes combinações de invocações.
- Botões e mecanismos que desbloqueiam objetivos.
- Plataformas e caminhos que exigem planejamento.
- Desafios que exploram o posicionamento dos objetos no cenário.

### Progressão

O jogo possui fases de tutorial para apresentar as mecânicas e quatro fases próprias, desenvolvidas para explorar diferentes combinações de puzzles e obstáculos.

---

## Controles

| Entrada | Ação |
|---|---|
| `A` / `D` | Movimentar o personagem horizontalmente. |
| `W` / `S` | Movimentar-se verticalmente enquanto estiver pendurado em uma corda. |
| Botão esquerdo do mouse | Posicionar o objeto mágico selecionado. |
| Botão direito do mouse | Cancelar a seleção da invocação. |
| `R` | Reiniciar a fase. |

### Invocação

Os objetos mágicos são selecionados por meio da interface do jogo:

1. Selecione a ponte, a corda ou a parede na interface.
2. Observe a pré-visualização do objeto seguindo o cursor.
3. Posicione o objeto no local desejado, respeitando o alinhamento do cenário.
4. Clique com o botão esquerdo para realizar a invocação.

A invocação consome mana de acordo com o objeto escolhido.

---

## Desenvolvimento

O projeto utiliza uma arquitetura baseada em cenas independentes e scripts reutilizáveis, facilitando a criação de novos obstáculos, objetos e fases.

### Tecnologias utilizadas

- **Godot Engine 4.7:** motor de desenvolvimento do jogo.
- **GDScript:** linguagem utilizada na programação das mecânicas.
- **Git:** controle de versão.
- **GitHub:** colaboração e gerenciamento do código-fonte.

### Organização do projeto

```text
ChamberEvoker/
│
├── Enemies/          # Inimigos e comportamentos
│
├── Globals/          # Sistemas e recursos globais
│
├── LevelObjects/     # Objetivos, botões e KillArea
│
├── Levels/
│   ├── TutorialLevels/
│   └── Levels1-4/
│
├── Menus/            # Menus e telas do jogo
│
├── Player/           # Personagem, movimentação e interface
│
├── Resources/        # Recursos e tilesets
│
├── Spawnables/       # Objetos mágicos e pré-visualizações
│
└── project.godot     # Configurações principais
```

---

## Como executar o projeto

1. Instale a [Godot Engine 4.7](https://godotengine.org/download/).
2. Clone este repositório:

```bash
git clone https://github.com/HericoSouza/NecroEvaders.git
```

3. Abra o Gerenciador de Projetos da Godot.
4. Clique em **Importar** e selecione o arquivo `project.godot`.
5. Abra o projeto e pressione `F5` para iniciar o jogo.

---

## Participação em Game Jam

Este projeto está sendo desenvolvido para a **[Hallow Jam 3: Invocação](https://itch.io/jam/hallowjam3)**, uma game jam organizada pelo Game Lab.

O tema da Jam é explorado por meio da mecânica central do jogo: a capacidade de invocar objetos mágicos e utilizá-los de maneira estratégica para solucionar puzzles e superar obstáculos.

**Evento:** [Hallow Jam 3 — Invocação](https://itch.io/jam/hallowjam3)

---

## Estado do projeto

**Status:** Em desenvolvimento.

O projeto possui sistemas de movimentação, invocação de objetos, gerenciamento de mana, interação com mecanismos e progressão entre fases.

As quatro fases próprias estão em desenvolvimento e refinamento, com foco na variedade dos puzzles e na utilização estratégica das habilidades mágicas.

Novas melhorias, ajustes de balanceamento e aprimoramentos visuais fazem parte do processo de desenvolvimento.

---

**ChamberEvoker**
