const crypto = require("crypto");
const request = require("request")
 
const llavePublicaAPI = `-----BEGIN PUBLIC KEY-----

-----END PUBLIC KEY-----`;
 
const credenciales = {
    USUARIO_ALIAS: "",
    USUARIO_CLAVE: "",
    MARCA_TIEMPO: new Date()
};
 
const credencialesCifradas = crypto.publicEncrypt({
        key: llavePublicaAPI,
        padding: crypto.constants.RSA_PKCS1_OAEP_PADDING,
        oaepHash: "sha256"
    },
    Buffer.from(JSON.stringify(credenciales))
);
 
let credencialesParaAPI = credencialesCifradas.toString("base64");
console.log(credencialesParaAPI);
 