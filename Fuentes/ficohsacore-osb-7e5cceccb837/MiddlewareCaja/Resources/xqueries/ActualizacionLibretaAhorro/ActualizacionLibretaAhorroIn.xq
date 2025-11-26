(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizacionLibretaAhorro" element="ns1:actualizacionLibretaAhorro" location="../../xsds/ActualizacionLibretaAhorro/ActualizacionLibretaAhorro.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$tellerPassbookEnquiryResponse" element="ns0:TellerPassbookEnquiryResponse" location="../../xsds/BkFicPBookEnq/XMLSchema_-1374990530.xsd" ::)
(:: pragma bea:global-element-return element="ns0:getPassBookDetails" location="../../xsds/BkFicCustRtn/XMLSchema_-517352168.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionLibretaAhorroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ActualizacionLibretaAhorroIn/";

declare function xf:ActualizacionLibretaAhorroIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $actualizacionLibretaAhorro as element(ns1:actualizacionLibretaAhorro),
    $tellerPassbookEnquiryResponse as element(ns0:TellerPassbookEnquiryResponse),
    $registros as xs:string)
    as element(ns0:getPassBookDetails) {
        <ns0:getPassBookDetails>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <PassBookReqType>
            	{
            		let $i := min( ($registros, count($tellerPassbookEnquiryResponse/NOFILETTTWSEXPType[1]/gNOFILETTTWSEXPDetailType/mNOFILETTTWSEXPDetailType)) )
            		let $NEXT_PASSBOOK_LINE := fn:string($actualizacionLibretaAhorro/NEXT_PASSBOOK_LINE/text())
            		let $last_line := xs:int($NEXT_PASSBOOK_LINE) + $i -1
            		let $ENTRYNO := fn:string($tellerPassbookEnquiryResponse/NOFILETTTWSEXPType[1]/gNOFILETTTWSEXPDetailType/mNOFILETTTWSEXPDetailType[xs:int($i)]/ENTRYNO/text())
            		let $ACCOUNT := fn:string($actualizacionLibretaAhorro/ACCOUNT_NUMBER/text())
            		let $PAGE_NUMBER := fn:string($actualizacionLibretaAhorro/PAGE_NUMBER/text())
					return
                        <PBOOKNO>{ concat($ACCOUNT, ":", $ENTRYNO, ":", $PAGE_NUMBER, ":", $last_line) }</PBOOKNO>
                }
            </PassBookReqType>
        </ns0:getPassBookDetails>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $actualizacionLibretaAhorro as element(ns1:actualizacionLibretaAhorro) external;
declare variable $tellerPassbookEnquiryResponse as element(ns0:TellerPassbookEnquiryResponse) external;
declare variable $registros as xs:string external;

xf:ActualizacionLibretaAhorroIn($autenticacionRequestHeader,
    $actualizacionLibretaAhorro,
    $tellerPassbookEnquiryResponse,
    $registros)