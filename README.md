# PEKORA: Privacy Enhanced Kawaii Online Resource for Adobe

https://pekora.update.sh/

This tool converts SRT subtitle files into Adobe Premiere Pro-compatible XML files
(specifically, FCP7 XML format).

The converted XML file can be imported into Adobe Premiere Pro and used as text
elements.

All conversion processes are performed within the browser, so the SRT subtitle files are
not uploaded to the server.

## FAQ

### Why is it called PEKORA?

We playfully named it "PEKORA" as a nod to [Usada Pekora](https://www.youtube.com/@usadapekora),
a Japanese virtual YouTuber who never fails to bring laughter and entertainment.

We couldn't resist injecting a bit of whimsical charm into our project by borrowing her name.

### How do I use it?

To use PEKORA, follow these steps:

1. Prepare an SRT subtitle file. (If you don't have one, you can generate one using [video-to-srt.bat](https://gist.github.com/rishubil/bc5dcadea00cc313980dbae47b885c4c))
2. Open https://pekora.update.sh/
3. Click the "Choose File" button and select the SRT subtitle file.
4. Customize the options, such as font name, font size, text color, etc., if desired.
5. Click the "Download Converted XML" button to save the converted XML file.
6. Import the downloaded XML file into Adobe Premiere Pro.

### What languages are supported?

PEKORA supports subtitles in any language. However, note that the availability of fonts in Adobe Premiere Pro may vary for different languages.

### Why did you make this?

We created this tool to address the challenges of manually inputting subtitles in Adobe Premiere. While automatic subtitle generation using AI technology has advanced, many users are hesitant to use existing services due to concerns about potential privacy breaches during the automated subtitle generation process.

To tackle this issue, we utilize the [Whisper](https://github.com/openai/whisper) model, which is an AI-powered technology for automatic subtitle generation. The advantage of Whisper is that it can be run locally on your computer, without the need for data to be sent to a server. This local execution ensures privacy and security by keeping all subtitle generation processes within your own environment.

However, there is still a need to convert the generated SRT subtitle files into FCP7 XML format, compatible with Adobe Premiere's Text Element. This is where our tool comes in. It automates the process of converting Whisper-generated SRT subtitle files into FCP7 XML files, eliminating the tedious task of manual subtitle input in Adobe Premiere.

By combining the benefits of local AI execution and automated conversion, our tool provides a seamless and privacy-conscious solution for integrating subtitles into Adobe Premiere projects.

### Source code?

You can access the source code of PEKORA at https://github.com/yf-dev/pekora

## License

MIT

But the favicon was generated using the following graphics from Twitter Twemoji:

- Graphics Title: 1f955.svg
- Graphics Author: Copyright 2020 Twitter, Inc and other contributors (https://github.com/twitter/twemoji)
- Graphics Source: https://github.com/twitter/twemoji/blob/master/assets/svg/1f955.svg
- Graphics License: CC-BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
