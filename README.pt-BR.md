<div align="center">

<img src="Sources/Assets.xcassets/AppIcon.appiconset/icon_256x256.png" width="128" alt="Halo">

# Halo

**O notch do seu Mac vira uma Dynamic Island para seus assistentes de código.**
Passe o mouse para ver quanto de cada limite de uso você já gastou, quando
ele renova, e se um agente ainda está trabalhando, terminou ou está esperando
por você.

![Platform](https://img.shields.io/badge/platform-macOS%2015%2B-black)
![Swift](https://img.shields.io/badge/swift-5-orange)
![License](https://img.shields.io/badge/license-MIT-green)

[English](README.md) · **Português** · [Español](README.es.md)

</div>

Halo é um fork do [Codenotch](https://github.com/vinzdg/codenotch), do Vinz,
refeito em torno de três ideias:

- **Só números reais.** Toda porcentagem vem do endpoint oficial de uso do
  provedor, o mesmo que o `/usage` da CLI dele lê. Halo nunca estima, projeta
  ou inventa uma janela que não recebeu.
- **O notch é a interface.** Em repouso, nada é desenhado: o recorte físico é
  o Halo. Aproxime o mouse e ele cresce a partir do recorte, como a Dynamic
  Island do iPhone. Sem alças, sem botões flutuantes, sem enfeite. Passe o
  mouse num anel e o relatório dele abre.
- **Fora do caminho.** Halo mora na barra de menus, não no Dock. Ajustes e
  Encerrar ficam a um clique do ícone do Halo.

## Instalar

[![Baixar para macOS](docs/design/download-macos.svg)](../../releases/latest/download/Halo.dmg)

O botão é a própria imagem de disco. O arquivo se chama `Halo.dmg` em todo
release, então esse link sempre resolve para o mais novo. Arraste o Halo para
Aplicativos e limpe a flag de quarentena uma vez (o build é assinado ad-hoc,
não notarizado):

```sh
xattr -dr com.apple.quarantine /Applications/Halo.app
```

Se o macOS disser que o app está *danificado*, é a flag de quarentena, não
um download ruim. Rode o comando acima.

Binário universal. macOS 15 ou superior. Fica melhor num Mac com notch
físico, onde o Halo se funde a ele; em qualquer outra tela ele desenha a
própria pílula na borda que você escolher.

## O que ele lê

Halo pega emprestada uma credencial ou sessão de uma ferramenta que já está
no seu Mac e consulta o endpoint oficial de uso do provedor. Nada é copiado,
renovado ou gravado de volta.

| Provedor | Fonte |
|---|---|
| **Claude Code** | Cache de uso do Claude Desktop, depois o `/usage` da CLI `claude`, depois o token OAuth do keychain contra `api.anthropic.com/api/oauth/usage`. Mostra a sessão de 5 horas, a janela semanal e as janelas semanais por modelo. |
| **Codex** | O login local do Codex. Limites de 5 horas e semanal, mais janelas extras quando a conta tem. |
| **Cursor** | A sessão logada do editor, ou o login `cursor-agent` do keychain. |
| **Antigravity** | O language server local, depois o endpoint de cota do Google. |
| **GitHub Copilot** | O endpoint de cota do Copilot via sessão da CLI `gh`. |
| **Kimi, Kiro, Grok, OpenCode, Command Code, GLM, MiniMax, DeepSeek, QianwenAI** | A sessão ou chave local de cada ferramenta, contra o endpoint oficial dela. |
| **Ollama, LM Studio** | Runtimes locais: modelos carregados, memória, uso de contexto e velocidade. |

Dois logins do Claude Code são dois anéis: qualquer diretório `~/.claude-<slug>`
que o Claude Code já usou ganha o próprio anel. Codex funciona igual com
`~/.codex-<slug>`.

## Sessões

Um arco fino gira dentro do anel de um provedor enquanto um agente está
ocupado, e vira um anel âmbar pulsante quando um deles está bloqueado esperando
por você. Passe o mouse para ver cada sessão ativa pelo nome e onde ela roda.
Quando uma sessão termina ou para pra te perguntar algo, o Halo abre por cinco
segundos e toca o alerta do sistema; clicar nele traz o app daquela sessão
para frente.

## Ajustes

No ícone da barra de menus, **Ajustes…**:

- **Notch**: qual borda, qual tela, e um controle deslizante contínuo de
  tamanho (60% a 200%) para casar o notch aberto com a sua tela.
- **Contas**: quais provedores aparecem e em que ordem.
- **Notificações**: limiares e alertas de renovação.
- **Telefone**: pareie o app de celular na mesma rede Wi-Fi para ver as mesmas
  leituras lá.

## Compilar

```sh
brew install xcodegen   # uma vez
make run                # gera, compila e abre um build de Debug
make test               # testes unitários
make dmg-ci             # imagem de disco sem assinatura em build/ci/
```

Xcode é necessário. Nenhuma identidade de assinatura é exigida.
`Scripts/sign-local.sh` assina o app com uma identidade autoassinada estável,
para que o "Permitir sempre" do keychain para o token do Claude sobreviva a
recompilações.

Rode com `HALO_DEMO=1` para dados de exemplo fixos.

## Créditos e licença

Halo deriva do [Codenotch](https://github.com/vinzdg/codenotch),
Copyright (c) 2026 Vinz, licença MIT. As mudanças do Halo são
Copyright (c) 2026 Jean Ribas e seguem a mesma licença MIT. Veja
[LICENSE](LICENSE).
