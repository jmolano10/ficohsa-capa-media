(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DCP/registrarVentaMenor/xsd/registraVentaMenor_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraVentaMenor";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/regVentaMenorIn/";

declare function xf:regVentaMenorIn($messageIn as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
        	let $messageList := fn:tokenize($messageIn,"@FM")
        	return(
            <ns0:PVDD>{ $messageList[2] }</ns0:PVDD>,
            <ns0:PVMT>{ $messageList[3] }</ns0:PVMT>,
            <ns0:PVIC>{ $messageList[4] }</ns0:PVIC>,
            <ns0:PVCC>{ $messageList[5] }</ns0:PVCC>,
            <ns0:PVFC>{ $messageList[6] }</ns0:PVFC>,
            <ns0:PTCM>{ $messageList[7] }</ns0:PTCM>,
            <ns0:PVMN>{ $messageList[8] }</ns0:PVMN>,
            <ns0:PVUB>{ $messageList[9] }</ns0:PVUB>,
            <ns0:PVAB>{ $messageList[10] }</ns0:PVAB>,
            <ns0:PTRX>{ $messageList[11] }</ns0:PTRX>
            )
        }
        </ns0:InputParameters>
};

declare variable $messageIn as xs:string external;

xf:regVentaMenorIn($messageIn)