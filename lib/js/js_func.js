// JavaScriptの関数定義
function callJsFunc(message) {
    console.log("Hello, world!");
    const returnMessage = "js function call: " + message;
    return returnMessage;
}

// 初期設定
let flag_speech = 0;
let result = [];
let recodingContents = "";
let continueRec = true;

// SpeechRecognitionの設定
const SpeechRecognition = webkitSpeechRecognition || SpeechRecognition;
const recognition = new SpeechRecognition();
recognition.lang = 'ja-JP';
recognition.interimResults = true;
recognition.continuous = true;

let finalTranscript = ''; // 確定した認識結果
let interimTranscript = ''; // 暫定の認識結果
let fff = ''; // 暫定の認識結果

function startRecording() {

    return new Promise((resolve, reject) => {
        navigator.mediaDevices.getUserMedia({ audio: true })
            .then(stream => {
                const mediaRecorder = new MediaRecorder(stream);
                let audioChunks = [];

                mediaRecorder.ondataavailable = event => {
                    audioChunks.push(event.data);
                };

                mediaRecorder.start();

                setTimeout(() => {
                    mediaRecorder.stop();
                }, 4500); // 4.5秒後に録音を停止

                mediaRecorder.onstop = () => {
                    const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
                    const reader = new FileReader();
                    reader.readAsArrayBuffer(audioBlob);
                    reader.onloadend = () => {
                        resolve(reader.result);
                    };
                };
            })
            .catch(error => reject(error));
    });
}





// 認識結果が得られたときの処理
recognition.onresult = (event) => {
    for (let i = event.resultIndex; i < event.results.length; i++) {
        const transcript = event.results[i][0].transcript;

        if (event.results[i].isFinal) {
            finalTranscript += transcript;
            result.push(transcript);
            recodingContents = "";
        } else {
            interimTranscript = transcript;
            console.log("[途中経過] " + interimTranscript);
            console.log('[finalのほう]' + finalTranscript);
            fff+=transcript;
            console.log('結果'+fff);
            recodingContents = transcript;
        }
    }
    console.log("[jsでの完成版]" + result.join(" ") + recodingContents);
};

// 音声認識を開始する関数
function vr_function() {
    result = [];
    recognition.start();
}

// 音声認識を終了する関数
function endRecoding() {
    recognition.stop();
    finalTranscript = '';
    interimTranscript = '';
}

// 結果をリストとして返す関数
function createList() {
    const send = result.join(" ");
    const sendList = [recodingContents, send, interimTranscript];
    return sendList;
}

//web限定 スマホで実行するとエラーが出るかも
//webのマイクがどの状態かをチェック
///todo スマホのブラウザでの実行確認
   function checkMicrophonePermission() {
   try{
   const userAgent = navigator.userAgent.toLowerCase().toString();
   }catch(e){
   userAgent = "error";
   }

    return userAgent;
  }






  ///todo 対象ブラウザかどうかの判定
  const browsersToCheck = ['Chrome', 'Safari', 'Edge', 'Opera'];
  function isSupportedBrowser() {
  // ブラウザのユーザーエージェント文字列を取得
     const userAgent = navigator.userAgent.toLowerCase();

     // 指定されたブラウザ名の配列をループで処理し、一致するものがあればfalseを返す
     for (const browserName of browsersToCheck) {
       if (userAgent.includes(browserName.toLowerCase())) {
         return false;
       }
     }

     // 一致するブラウザがなかった場合はfalseを返す
     return true;
  }

}

