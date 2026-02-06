xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../Precredit/validaListaNegraOfacONU/xsd/validaListaNegraOfacONU_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaListaNegraOfacONU";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaListasClienteGT/xq/validaListaNegraOfacONUIn/";

declare function xf:validaListaNegraOfacONUIn($legalId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:IDENTIDAD>{ $legalId }</ns0:IDENTIDAD>
        </ns0:InputParameters>
};

declare variable $legalId as xs:string external;

xf:validaListaNegraOfacONUIn($legalId)