<template>
  <div class="bg-pekora-blue-100 min-h-screen text-pekora-blue-950">
    <div class="container max-w-[100ch] mx-auto flex flex-col gap-4 py-8 px-4">
      <div class="rounded bg-white shadow p-4 mb-8">
        <h1 class="text-2xl text-pekora-blue-900 font-extrabold text-center pt-2">
          PEKORA: Privacy Enhanced Kawaii Online Resource for Adobe
        </h1>
        <h2 class="text-xl text-pekora-blue-800 font-bold text-center pt-4 pb-4">
          Convert Subtitles to Adobe Premiere Pro XML Format
        </h2>
        <p class="px-4 mb-2">
          This tool converts SRT subtitle files into Adobe Premiere Pro-compatible XML files
          (specifically, FCP7 XML format).
        </p>
        <p class="px-4 mb-2">
          The converted XML file can be imported into Adobe Premiere Pro and used as text elements.
        </p>
        <p class="px-4 mb-2">
          All conversion processes are performed within the browser, so the SRT subtitle files are
          not uploaded to the server.
        </p>
      </div>
      <div class="rounded bg-white shadow p-4">
        <h3 class="text-lg text-pekora-blue-700 font-bold text-center pt-2 pb-6">Basic Options</h3>
        <form class="grid grid-cols-auto-fit-w-72 gap-x-6 gap-y-3">
          <InputBox v-model="name" name="Sequence Name" input-type="text"></InputBox>
          <InputBox v-model="srtFiles" name="SRT File" input-type="file"></InputBox>
        </form>
      </div>
      <div class="rounded bg-white shadow p-4">
        <h3 class="text-lg text-pekora-blue-700 font-bold text-center pt-2 pb-6">
          Subtitle Options
        </h3>
        <form class="grid grid-cols-auto-fit-w-72 gap-x-6 gap-y-3">
          <InputBox v-model="fontName" name="Font name" input-type="text"></InputBox>
          <InputBox v-model="textSize" name="Text Size" input-type="number" step="any"></InputBox>
          <InputBox v-model="textColor" name="Text Color" input-type="color"></InputBox>
          <InputBox
            v-model="horizontalCenter"
            name="Horizontal Center"
            input-type="number"
            step="any"
          ></InputBox>
          <InputBox
            v-model="verticalCenter"
            name="Vertical Center"
            input-type="number"
            step="any"
          ></InputBox>
          <InputBox
            v-model="strokeWidth"
            name="Stroke Width"
            input-type="number"
            step="any"
          ></InputBox>
          <InputBox v-model="strokeColor" name="Stroke Color" input-type="color"></InputBox>
        </form>
      </div>
      <div class="rounded bg-white shadow p-4">
        <h3 class="text-lg text-pekora-blue-700 font-bold text-center pt-2 pb-6">Video Options</h3>
        <form class="grid grid-cols-auto-fit-w-72 gap-x-6 gap-y-3">
          <InputBox v-model="framerate" name="Framerate" input-type="number" step="any"></InputBox>
          <InputBox
            v-model="isNtsc"
            name="NTSC rate reduction"
            input-type="select"
            :options="[
              { value: true, label: 'Yes' },
              { value: false, label: 'No' },
            ]"
          ></InputBox>
          <InputBox v-model="width" name="Width" input-type="number" :step="1"></InputBox>
          <InputBox v-model="height" name="Height" input-type="number" :step="1"></InputBox>
          <InputBox
            v-model="isAnamorphic"
            name="Anamorphic"
            input-type="select"
            :options="[
              { value: true, label: '16:9' },
              { value: false, label: '4:3' },
            ]"
          ></InputBox>
          <InputBox
            v-model="pixelAspectRatio"
            name="Pixel Aspect Ratio"
            input-type="select"
            :options="[
              { value: 'NTSC-601', label: 'NTSC-601' },
              { value: 'PAL-601', label: 'PAL-601' },
              { value: 'square', label: 'Square' },
              { value: 'DVCPROHD-720P', label: 'DVCPROHD-720P' },
              { value: 'HD-(960x720)', label: 'HD-(960x720)' },
              { value: 'DVCPROHD-1080i60', label: 'DVCPROHD-1080i60' },
              { value: 'HD-(1280x1080)', label: 'HD-(1280x1080)' },
              { value: 'DVCPROHD-1080i50', label: 'DVCPROHD-1080i50' },
              { value: 'HD-(1440x1080)', label: 'HD-(1440x1080)' },
            ]"
          ></InputBox>
          <InputBox
            v-model="fieldDominance"
            name="Field Dominance"
            input-type="select"
            :options="[
              { value: 'none', label: 'None' },
              { value: 'lower', label: 'Lower' },
              { value: 'upper', label: 'Upper' },
              { value: 'odd', label: 'Odd' },
              { value: 'even', label: 'Even' },
            ]"
          ></InputBox>
        </form>
      </div>
      <button
        class="rounded shadow text-white border bg-pekora-blue-500 py-2 px-4 font-bold hover:bg-pekora-blue-600"
        type="button"
        @click="downloadXml"
      >
        Download Converted XML
      </button>
      <div class="rounded bg-white shadow p-4 mt-8">
        <h1 class="text-2xl text-pekora-blue-900 font-extrabold text-center pt-2">FAQ</h1>
        <h2 class="text-xl text-pekora-blue-800 font-bold text-center pt-4 pb-4">
          Why is it called PEKORA?
        </h2>
        <p class="px-4 mb-2">
          We playfully named it "PEKORA" as a nod to
          <a
            href="https://www.youtube.com/@usadapekora"
            class="text-pekora-blue-800 underline underline-offset-2"
            >Usada Pekora</a
          >, a Japanese virtual YouTuber who never fails to bring laughter and entertainment.
        </p>
        <p class="px-4 mb-2">
          We couldn't resist injecting a bit of whimsical charm into our project by borrowing her
          name.
        </p>
        <h2 class="text-xl text-pekora-blue-800 font-bold text-center pt-4 pb-4">
          How do I use it?
        </h2>
        <p class="px-4 mb-2">To use PEKORA, follow these steps:</p>
        <ol class="px-4 mb-2 list-inside list-decimal">
          <li class="mb-2 ms-4">
            Prepare an SRT subtitle file. (If you don't have one, you can generate one using
            <a
              href="https://gist.github.com/rishubil/bc5dcadea00cc313980dbae47b885c4c"
              class="text-pekora-blue-800 underline underline-offset-2"
              >video-to-srt.bat</a
            >)
          </li>
          <li class="mb-2 ms-4">
            Click the "Choose File" button and select the SRT subtitle file.
          </li>
          <li class="mb-2 ms-4">
            Customize the options, such as font name, font size, text color, etc., if desired.
          </li>
          <li class="mb-2 ms-4">
            Click the "Download Converted XML" button to save the converted XML file.
          </li>
          <li class="mb-2 ms-4">Import the downloaded XML file into Adobe Premiere Pro.</li>
        </ol>
        <h2 class="text-xl text-pekora-blue-800 font-bold text-center pt-4 pb-4">
          What languages are supported?
        </h2>
        <p class="px-4 mb-2">
          PEKORA supports subtitles in any language. However, note that the availability of fonts in
          Adobe Premiere Pro may vary for different languages.
        </p>
        <h2 class="text-xl text-pekora-blue-800 font-bold text-center pt-4 pb-4">
          Why did you make this?
        </h2>
        <p class="px-4 mb-2">
          We created this tool to address the challenges of manually inputting subtitles in Adobe
          Premiere. While automatic subtitle generation using AI technology has advanced, many users
          are hesitant to use existing services due to concerns about potential privacy breaches
          during the automated subtitle generation process.
        </p>
        <p class="px-4 mb-2">
          To tackle this issue, we utilize the
          <a
            href="https://github.com/openai/whisper"
            class="text-pekora-blue-800 underline underline-offset-2"
            >Whisper</a
          >
          model, which is an AI-powered technology for automatic subtitle generation. The advantage
          of Whisper is that it can be run locally on your computer, without the need for data to be
          sent to a server. This local execution ensures privacy and security by keeping all
          subtitle generation processes within your own environment.
        </p>
        <p class="px-4 mb-2">
          However, there is still a need to convert the generated SRT subtitle files into FCP7 XML
          format, compatible with Adobe Premiere's Text Element. This is where our tool comes in. It
          automates the process of converting Whisper-generated SRT subtitle files into FCP7 XML
          files, eliminating the tedious task of manual subtitle input in Adobe Premiere.
        </p>
        <p class="px-4 mb-2">
          By combining the benefits of local AI execution and automated conversion, our tool
          provides a seamless and privacy-conscious solution for integrating subtitles into Adobe
          Premiere projects.
        </p>
        <h2 class="text-xl text-pekora-blue-800 font-bold text-center pt-4 pb-4">Source code?</h2>
        <p class="px-4 mb-2">
          You can access the source code of PEKORA at
          <a
            href="https://github.com/yf-dev/pekora"
            class="text-pekora-blue-800 underline underline-offset-2"
            >https://github.com/yf-dev/pekora</a
          >
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import InputBox from './components/InputBox.vue'
import { ref } from 'vue'
import { parseSync, type NodeCue, type NodeList as SubtitleNodeList } from 'subtitle'
import {
  DEFAULT_NAME,
  DEFAULT_FRAMERATE,
  DEFAULT_IS_NTSC,
  DEFAULT_WIDTH,
  DEFAULT_HEIGHT,
  DEFAULT_IS_ANAMORPHIC,
  DEFAULT_PIXEL_ASPECT_RATIO,
  DEFAULT_FIELD_DOMINANCE,
  DEFAULT_FONT_FAME,
  DEFAULT_FONT_SIZE as DEFAULT_TEXT_SIZE,
  DEFAULT_VERTICAL_CENTER,
  DEFAULT_HORIZONTAL_CENTER,
  DEFAULT_STROKE_WIDTH,
  DEFAULT_TEXT_COLOR,
  DEFAULT_STROKE_COLOR,
} from './consts'

const name = ref(DEFAULT_NAME)
const srtFiles = ref<FileList | null>(null)
const framerate = ref(DEFAULT_FRAMERATE)
const isNtsc = ref(DEFAULT_IS_NTSC)
const width = ref(DEFAULT_WIDTH)
const height = ref(DEFAULT_HEIGHT)
const isAnamorphic = ref(DEFAULT_IS_ANAMORPHIC)
const pixelAspectRatio = ref(DEFAULT_PIXEL_ASPECT_RATIO)
const fieldDominance = ref(DEFAULT_FIELD_DOMINANCE)
const fontName = ref(DEFAULT_FONT_FAME)
const textSize = ref(DEFAULT_TEXT_SIZE)
const textColor = ref(DEFAULT_TEXT_COLOR)
const horizontalCenter = ref(DEFAULT_HORIZONTAL_CENTER)
const verticalCenter = ref(DEFAULT_VERTICAL_CENTER)
const strokeWidth = ref(DEFAULT_STROKE_WIDTH)
const strokeColor = ref(DEFAULT_STROKE_COLOR)

function toNumberString(n: number): string {
  if (Number.isInteger(n)) {
    return n + '.0'
  } else {
    return n.toString()
  }
}

function hexToRgb(hex: string): { red: number; green: number; blue: number } {
  if (hex.startsWith('#')) {
    hex = hex.slice(1)
  }
  var bigint = parseInt(hex, 16)
  var r = (bigint >> 16) & 255
  var g = (bigint >> 8) & 255
  var b = bigint & 255

  return {
    red: r,
    green: g,
    blue: b,
  }
}

function parseSrtFile(): Promise<SubtitleNodeList> {
  return new Promise((resolve, reject) => {
    const file = srtFiles.value?.[0]
    if (!file) {
      reject(new Error('No SRT file selected'))
      return
    }

    const reader = new FileReader()
    reader.onload = () => {
      const srt = reader.result as string
      const subtitles = parseSync(srt)
      resolve(subtitles)
    }
    reader.readAsText(file)
    reader.onerror = reject
  })
}

function createXmlNode(
  root: XMLDocument,
  parent: Element | XMLDocument | null,
  name: string,
  options: {
    textContent?: string
    attributes?: Record<string, string>
  },
): Element {
  const node = root.createElement(name)
  if (options.textContent) {
    node.textContent = options.textContent
  }
  if (options.attributes) {
    for (const [key, value] of Object.entries(options.attributes)) {
      node.setAttribute(key, value)
    }
  }
  if (parent) {
    parent.appendChild(node)
  }
  return node
}

function createEffectParameterNode(
  root: XMLDocument,
  option: {
    parameterid: string
    name: string
    valuemin?: string
    valuemax?: string
    valuelist?: { name: string; value: string }[]
    value?: string | Record<string, string> | null
  },
): Element {
  const node = createXmlNode(root, null, 'parameter', {})
  createXmlNode(root, node, 'parameterid', {
    textContent: option.parameterid,
  })
  createXmlNode(root, node, 'name', {
    textContent: option.name,
  })
  if (option.valuemin) {
    createXmlNode(root, node, 'valuemin', {
      textContent: option.valuemin,
    })
  }
  if (option.valuemax) {
    createXmlNode(root, node, 'valuemax', {
      textContent: option.valuemax,
    })
  }
  if (option.valuelist) {
    const valuelistNode = createXmlNode(root, node, 'valuelist', {})
    for (const { name, value } of option.valuelist) {
      const valueentryNode = createXmlNode(root, valuelistNode, 'valueentry', {})
      createXmlNode(root, valueentryNode, 'name', {
        textContent: name,
      })
      createXmlNode(root, valueentryNode, 'value', {
        textContent: value,
      })
    }
  }
  if (option.value !== undefined) {
    if (option.value === null) {
      createXmlNode(root, node, 'value', {})
    } else if (typeof option.value === 'string') {
      createXmlNode(root, node, 'value', {
        textContent: option.value,
      })
    } else {
      const valueNode = createXmlNode(root, node, 'value', {})
      for (const [key, value] of Object.entries(option.value)) {
        createXmlNode(root, valueNode, key, {
          textContent: value,
        })
      }
    }
  }
  return node
}

function convertCueToGeneratoritemXml(
  cue: NodeCue,
  duration: number,
  root: XMLDocument,
  index: number,
) {
  const subId = `Subtitle ${index + 1}`
  const subName = `Subtitle(${cue.data.text.trim()})`

  const generatoritemNode = createXmlNode(root, null, 'generatoritem', {
    attributes: {
      id: subId,
    },
  })

  createXmlNode(root, generatoritemNode, 'name', {
    textContent: subName,
  })
  createXmlNode(root, generatoritemNode, 'duration', {
    textContent: toNumberString(duration),
  })

  const rateNode = createXmlNode(root, generatoritemNode, 'rate', {})

  createXmlNode(root, rateNode, 'timebase', {
    textContent: toNumberString(framerate.value),
  })
  createXmlNode(root, rateNode, 'ntsc', {
    textContent: isNtsc.value ? 'true' : 'false',
  })

  createXmlNode(root, generatoritemNode, 'start', {
    textContent: toNumberString((cue.data.start * framerate.value) / 1000),
  })
  createXmlNode(root, generatoritemNode, 'end', {
    textContent: toNumberString((cue.data.end * framerate.value) / 1000),
  })
  createXmlNode(root, generatoritemNode, 'in', {
    textContent: toNumberString((cue.data.start * framerate.value) / 1000),
  })
  createXmlNode(root, generatoritemNode, 'out', {
    textContent: toNumberString((cue.data.end * framerate.value) / 1000),
  })
  createXmlNode(root, generatoritemNode, 'enabled', {
    textContent: 'true',
  })
  createXmlNode(root, generatoritemNode, 'anamorphic', {
    textContent: 'false',
  })
  createXmlNode(root, generatoritemNode, 'alphatype', {
    textContent: 'black',
  })
  createXmlNode(root, generatoritemNode, 'masterclipid', {
    textContent: subId,
  })

  const effectNode = createXmlNode(root, generatoritemNode, 'effect', {})

  createXmlNode(root, effectNode, 'name', {
    textContent: 'Outline Text',
  })
  createXmlNode(root, effectNode, 'effectid', {
    textContent: 'Outline Text',
  })
  createXmlNode(root, effectNode, 'effectcategory', {
    textContent: 'Text',
  })
  createXmlNode(root, effectNode, 'effecttype', {
    textContent: 'generator',
  })
  createXmlNode(root, effectNode, 'mediatype', {
    textContent: 'video',
  })

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'part1',
      name: 'Text Settings',
      value: null,
    }),
  )
  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'str',
      name: 'Text',
      value: cue.data.text.trim(),
    }),
  )
  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'font',
      name: 'Font',
      value: fontName.value,
    }),
  )
  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'align',
      name: 'Alignment',
      valuemin: '1',
      valuemax: '3',
      valuelist: [
        {
          name: 'Left',
          value: '1',
        },
        {
          name: 'Center',
          value: '2',
        },
        {
          name: 'Right',
          value: '3',
        },
      ],
      value: '2',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'size',
      name: 'Size',
      valuemin: '0',
      valuemax: '200',
      value: toNumberString(textSize.value),
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'aspect',
      name: 'Aspect',
      valuemin: '0',
      valuemax: '4',
      value: '1',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'linewidth',
      name: 'Line Width',
      valuemin: '0',
      valuemax: '200',
      value: toNumberString(strokeWidth.value),
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'center',
      name: 'Center',
      value: {
        horiz: toNumberString(horizontalCenter.value),
        vert: toNumberString(verticalCenter.value),
      },
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'textcolor',
      name: 'Text Color',
      value: {
        alpha: '255',
        red: hexToRgb(textColor.value).red.toString(),
        green: hexToRgb(textColor.value).green.toString(),
        blue: hexToRgb(textColor.value).blue.toString(),
      },
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'supertext',
      name: 'Text Graphic',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'linecolor',
      name: 'Line Color',
      value: {
        alpha: '255',
        red: hexToRgb(strokeColor.value).red.toString(),
        green: hexToRgb(strokeColor.value).green.toString(),
        blue: hexToRgb(strokeColor.value).blue.toString(),
      },
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'superline',
      name: 'Line Graphic',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'part2',
      name: 'Background Settings',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'xscale',
      name: 'Horizontal Size',
      valuemin: '0',
      valuemax: '200',
      value: '0',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'yscale',
      name: 'Vertical Size',
      valuemin: '0',
      valuemax: '200',
      value: '0',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'xoffset',
      name: 'Horizontal Offset',
      valuemin: '-100',
      valuemax: '100',
      value: '0',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'yoffset',
      name: 'Vertical Offset',
      valuemin: '-100',
      valuemax: '100',
      value: '0',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'backsoft',
      name: 'Back Soft',
      valuemin: '0',
      valuemax: '100',
      value: '0',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'backopacity',
      name: 'Back Opacity',
      valuemin: '0',
      valuemax: '100',
      value: '0',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'backcolor',
      name: 'Back Color',
      value: {
        alpha: '255',
        red: '0',
        green: '0',
        blue: '0',
      },
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'superback',
      name: 'Back Graphic',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'crop',
      name: 'Crop',
      value: 'false',
    }),
  )

  effectNode.appendChild(
    createEffectParameterNode(root, {
      parameterid: 'autokern',
      name: 'Auto Kerning',
      value: 'true',
    }),
  )

  const sourcetrackNode = createXmlNode(root, generatoritemNode, 'sourcetrack', {})
  createXmlNode(root, sourcetrackNode, 'mediatype', {
    textContent: 'video',
  })

  return generatoritemNode
}

function convertSubtitlesToXml(nodes: SubtitleNodeList): string {
  const root = document.implementation.createDocument('', '', null)
  const pi = root.createProcessingInstruction('xml', 'version="1.0" encoding="utf-8"')
  root.insertBefore(pi, root.firstChild)

  const cues = nodes.filter((x) => x.type === 'cue') as NodeCue[]
  const duration = (cues[cues.length - 1].data.end * framerate.value) / 1000

  const xmemlNode = createXmlNode(root, root, 'xmeml', {
    attributes: {
      version: '5',
    },
  })

  const sequenceNode = createXmlNode(root, xmemlNode, 'sequence', {
    attributes: {
      id: 'Subtitle Sequence',
    },
  })

  createXmlNode(root, sequenceNode, 'name', {
    textContent: name.value,
  })
  createXmlNode(root, sequenceNode, 'duration', {
    textContent: toNumberString(duration),
  })

  const rateNode = createXmlNode(root, sequenceNode, 'rate', {})

  createXmlNode(root, rateNode, 'timebase', {
    textContent: toNumberString(framerate.value),
  })
  createXmlNode(root, rateNode, 'ntsc', {
    textContent: isNtsc.value ? 'true' : 'false',
  })

  const mediaNode = createXmlNode(root, sequenceNode, 'media', {})
  const videoNode = createXmlNode(root, mediaNode, 'video', {})
  const formatNode = createXmlNode(root, videoNode, 'format', {})
  const samplecharacteristicsNode = createXmlNode(root, formatNode, 'samplecharacteristics', {})

  createXmlNode(root, samplecharacteristicsNode, 'width', {
    textContent: width.value.toString(),
  })
  createXmlNode(root, samplecharacteristicsNode, 'height', {
    textContent: height.value.toString(),
  })
  createXmlNode(root, samplecharacteristicsNode, 'anamorphic', {
    textContent: isAnamorphic.value ? 'true' : 'false',
  })
  createXmlNode(root, samplecharacteristicsNode, 'pixelaspectratio', {
    textContent: pixelAspectRatio.value,
  })
  createXmlNode(root, samplecharacteristicsNode, 'fielddominance', {
    textContent: fieldDominance.value,
  })

  const trackNode = createXmlNode(root, videoNode, 'track', {})

  for (let index = 0; index < cues.length; index++) {
    const cue = cues[index]

    const generatoritemNode = convertCueToGeneratoritemXml(cue, duration, root, index)
    trackNode.appendChild(generatoritemNode)
  }

  return new XMLSerializer().serializeToString(root)
}

async function downloadXml() {
  let nodes: SubtitleNodeList | null = null
  try {
    nodes = await parseSrtFile()
  } catch (error) {
    alert(error)
    return
  }
  const xmlData = convertSubtitlesToXml(nodes)

  let xmlFileName = 'converted.xml'
  const srtFile = srtFiles.value?.[0]
  if (srtFile) {
    xmlFileName = `${srtFile.name}.xml`
  }

  const blob = new Blob([xmlData], { type: 'application/xml' })
  const link = document.createElement('a')
  link.href = URL.createObjectURL(blob)
  link.download = xmlFileName
  link.click()
  link.remove()
  URL.revokeObjectURL(link.href)
}
</script>
