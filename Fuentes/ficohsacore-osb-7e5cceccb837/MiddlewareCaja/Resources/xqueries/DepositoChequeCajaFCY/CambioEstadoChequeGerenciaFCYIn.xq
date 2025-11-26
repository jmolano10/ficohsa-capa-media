(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoChequeCajaFCY" element="ns0:depositoChequeCajaFCY" location="../../xsds/DepositoChequeCajaFCY/DepositoChequeCajaFCY.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaFCYResponse" element="ns1:ConsultadechequedegerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CambioestadochqgerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCajaFCYTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCajaFCY/CambioEstadoChequeGerenciaFCYIn/";

declare function xf:CambioEstadoChequeGerenciaFCYIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY),
    $consultadechequedegerenciaFCYResponse as element(ns1:ConsultadechequedegerenciaFCYResponse))
    as element(ns1:CambioestadochqgerenciaFCY) {
        <ns1:CambioestadochqgerenciaFCY>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FICOFCYDRAFTDETAILSFICOHNINPUTWSType id = "{ concat(fn:string($consultadechequedegerenciaFCYResponse/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Nostro/text()),".", fn:string($depositoChequeCajaFCY/CHECK_NUMBER/text())) }">
                <ChequeStatus>LOCALLY.PAID</ChequeStatus>
            </FICOFCYDRAFTDETAILSFICOHNINPUTWSType>
        </ns1:CambioestadochqgerenciaFCY>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY) external;
declare variable $consultadechequedegerenciaFCYResponse as element(ns1:ConsultadechequedegerenciaFCYResponse) external;

xf:CambioEstadoChequeGerenciaFCYIn($autenticacionRequestHeader,
    $depositoChequeCajaFCY,
    $consultadechequedegerenciaFCYResponse)