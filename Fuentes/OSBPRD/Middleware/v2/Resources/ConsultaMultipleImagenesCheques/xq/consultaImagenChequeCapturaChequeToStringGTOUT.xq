(:: pragma bea:global-element-parameter parameter="$verChequeResponse1" element="ns0:verChequeResponse" location="../../../BusinessServices/ABKGT/vercheques/wsdl/consultaCapturaChequeGTPS.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaImagenCheque/xq/prueba/";


declare function xf:prueba($verChequeResponse1 as element(ns0:verChequeResponse))
    as xs:string {
         $verChequeResponse1/ns0:verChequeResult/text()
};

declare variable $verChequeResponse1 as element(ns0:verChequeResponse) external;

xf:prueba($verChequeResponse1)