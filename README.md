# NecroEvaders

<p align="center">
  <strong>Um jogo 2D sobre magia, reflexos e sobrevivência.</strong>
</p>

NecroEvaders é um projeto de jogo 2D desenvolvido na **Godot Engine**, com elementos de plataforma, runner e desafios baseados em reflexos e precisão.

## Sobre o jogo

Em um universo onde os magos invocadores são divididos entre aqueles que utilizam magia para criar objetos e aqueles que invocam criaturas, existe uma proibição: magos do bem não podem invocar seres vivos.

Nosso protagonista pertence ao grupo dos invocadores de objetos e parte em uma jornada para capturar magos necromantes, responsáveis por invocar criaturas e espalhar o caos.

Para avançar, será necessário utilizar objetos mágicos, superar obstáculos e sobreviver às armadilhas preparadas pelos inimigos.

## Mecânicas

### Invocação de objetos

O protagonista não pode invocar criaturas. Suas habilidades são voltadas à criação de objetos que permitem superar os obstáculos.

- **Pontes:** utilizadas para atravessar poços sem espinhos.
- **Cordas:** permitem suspender o personagem e atravessar poços com espinhos.
- **Paredes:** utilizadas para bloquear hordas de criaturas.

### Movimentação

- Corrida automática para a direita.
- Salto controlado pelo jogador.
- Travessias que exigem combinações de ações.
- Obstáculos que exigem precisão no momento da invocação.

### Inimigos

Os necromantes utilizam criaturas invocadas para impedir o avanço do protagonista. Entre os desafios previstos estão hordas de esqueletos e confrontos contra chefes.

## Controles

| Tecla | Ação |
|---|---|
| `1` | Invocar ponte |
| `2` | Invocar corda |
| `3` | Invocar parede |
| `Espaço` | Pular |

## Tecnologias

- Godot Engine 4.7
- GDScript
- Git
- GitHub

## Estrutura do projeto

O projeto utiliza cenas independentes e scripts próprios para organizar as mecânicas.

| Arquivo | Responsabilidade |
|---|---|
| `fase_1.tscn` | Cenário principal da primeira fase |
| `mago.gd` | Movimentação, salto e invocações do protagonista |
| `poco.tscn` | Obstáculo de poço comum |
| `poco_espinhos.tscn` | Obstáculo de poço com espinhos |
| `ponte.tscn` | Objeto mágico de travessia |
| `armadilha_esqueletos.tscn` | Ativação da horda |
| `horda_esqueletos.tscn` | Organização e movimentação dos inimigos |
| `esqueleto.tscn` | Entidade inimiga |
| `parede_horda.tscn` | Parede invocada para bloquear a horda |

## Como executar

1. Instale a Godot Engine 4.7 ou uma versão compatível.
2. Clone este repositório ou faça download do zip
3. Execute o projeto com o F6

## Participação em Game Jam

Este projeto está sendo desenvolvido para a **[Hallow Jam 3: Invocação](https://itch.io/jam/hallowjam3)**, uma game jam organizada pelo Game Lab.

A proposta do NecroEvaders explora o tema da invocação por meio de mecânicas centrais de gameplay, nas quais o jogador precisa conjurar objetos mágicos para superar obstáculos, escapar de criaturas e enfrentar desafios.

**Período da Jam:** 23/10/2026 a 02/11/2026.

**Tema:** Invocação.
