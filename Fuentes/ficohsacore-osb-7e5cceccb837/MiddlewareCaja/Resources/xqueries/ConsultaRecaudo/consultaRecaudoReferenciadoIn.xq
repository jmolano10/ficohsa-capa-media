(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../../xsds/ConsultaRecaudo/ConsultaRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudoreferenciadoefec_Validate" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudo/consultaRecaudoReferenciadoIn/";

declare function xf:consultaRecaudoReferenciadoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudo as element(ns1:consultaRecaudo))
    as element(ns0:Pagoderecaudoreferenciadoefec_Validate) {
        <ns0:Pagoderecaudoreferenciadoefec_Validate>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
			<OfsFunction>
				<gtsControl></gtsControl>
				<messageId></messageId>
				<noOfAuth></noOfAuth>
				<replace></replace>
			</OfsFunction>            
            <TELLERREFCOLLCASHWSCOPYType>
                <CURRENCY1>{ data($consultaRecaudo/CURRENCY) }</CURRENCY1>
                <LRPAYCODE>{ data($consultaRecaudo/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    <mLRINVOICENO>
                        <LRINVOICENO>123</LRINVOICENO>
                        <LRDUEDATE>{ data($consultaRecaudo/BILL_DATE) }</LRDUEDATE>
                        <LRAMT>{ concat($consultaRecaudo/CURRENCY , $consultaRecaudo/BILL_AMOUNT) }</LRAMT>
                        <LRPAYYN>Y</LRPAYYN>
                    </mLRINVOICENO>
                </gLRINVOICENO>
                <gLRTAXPAYNAME>
                    <LRTAXPAYNAME>BANCO FICOHSA</LRTAXPAYNAME>
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($consultaRecaudo/CONTRACT_ID) }</LRAGCLIENTID>
            </TELLERREFCOLLCASHWSCOPYType>
        </ns0:Pagoderecaudoreferenciadoefec_Validate>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;

xf:consultaRecaudoReferenciadoIn($autenticacionRequestHeader,
    $consultaRecaudo)