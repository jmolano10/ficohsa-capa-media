xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DCP/reversaVentaMenor/xsd/reversarVentaMenor_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reversarVentaMenor";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/revVentaMenor/";

declare function xf:revVentaMenor($messageIn as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        {
        	let $messageList := fn:tokenize($messageIn,"@FM")
        	return
        	(
            <ns0:PRCV>{ $messageList[2] }</ns0:PRCV>,
            <ns0:PVFC>{ $messageList[6] }</ns0:PVFC>,
            <ns0:PVUB>{ $messageList[9] }</ns0:PVUB>,
            <ns0:PVAB>{ $messageList[10] }</ns0:PVAB>,
            <ns0:PTRX>{ $messageList[11] }</ns0:PTRX>
            )
        }
        </ns0:InputParameters>
};

declare variable $messageIn as xs:string external;

xf:revVentaMenor($messageIn)