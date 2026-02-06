xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleImagenesCheques/xq/consultaImagenChequeNIHeaderOUT";

declare function xf:consultaImagenChequeNIHeaderOUT($ErrorCode as xs:string,
    $MessageError as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ $ErrorCode }</successIndicator>
            {
            if ($ErrorCode!='Success') then(
            <messages>{ $MessageError }</messages>          
            )else()
            }
        </ns0:ResponseHeader>
};

declare variable $ErrorCode as xs:string external;
declare variable $MessageError as xs:string external;

xf:consultaImagenChequeNIHeaderOUT($ErrorCode,
    $MessageError)