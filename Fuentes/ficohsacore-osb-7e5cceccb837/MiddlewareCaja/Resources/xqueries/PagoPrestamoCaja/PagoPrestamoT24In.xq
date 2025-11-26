(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo1" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoaprestamoAA" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoT24In/";

declare function xf:PagoPrestamoT24In($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo1 as element(ns0:pagoPrestamo),
    $uuid as xs:string)
    as element(ns1:PagoaprestamoAA) {
        <ns1:PagoaprestamoAA>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader1/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader1/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERFINANCIALSERVICESLOANPAYMENTWSType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <TRANSCTION>
                        {
                            if (data($pagoPrestamo1/PAYMENT_TYPE) = "CASH") then (
                                if (data($pagoPrestamo1/PAYMENT_CURRENCY) = "HNL") then (
                                	"PR.MN.MN"
                                ) else (
                                	"PR.VARIASMND.ME"
                                )
                            ) else if (data($pagoPrestamo1/PAYMENT_TYPE) = "ACCOUNT_DEBIT") then (
                                "PR.ACT.DB"
                            ) else if (data($pagoPrestamo1/PAYMENT_TYPE) = "OWN_CHEQUE") then (
                                "FICO.CHQ"
                            ) else if (data($pagoPrestamo1/PAYMENT_TYPE) = "OTHER_BANK_CHEQUE") then (
                            	"CLEARING"
                            ) else ()
                        }
						</TRANSCTION>
                        {
                            for $DEBIT_ACCOUNT in $pagoPrestamo1/DEBIT_ACCOUNT
                            return
                                <SURROGATEAC>{ data($DEBIT_ACCOUNT) }</SURROGATEAC>
                        }
                        <CURRENCY>{ data($pagoPrestamo1/PAYMENT_CURRENCY) }</CURRENCY>
                        <AMOOUNT>{ data($pagoPrestamo1/PAYMENT_AMOUNT) }</AMOOUNT>
                        {
                            for $BANK_CODE in $pagoPrestamo1/BANK_CODE
                            return
                                <SORTCODE>{ data($BANK_CODE) }</SORTCODE>
                        }
                        {
                            for $CHEQUE_NUMBER in $pagoPrestamo1/CHEQUE_NUMBER
                            return
                                <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                        }
                    </mTRANSACTION>
                </gTRANSACTION>
                <LRLOANNO>{ data($pagoPrestamo1/LOAN_NUMBER) }</LRLOANNO>
                <LRWAIVECHG>NO</LRWAIVECHG>
            </TELLERFINANCIALSERVICESLOANPAYMENTWSType>
        </ns1:PagoaprestamoAA>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo1 as element(ns0:pagoPrestamo) external;
declare variable $uuid as xs:string external;

xf:PagoPrestamoT24In($autenticacionRequestHeader1,
    $pagoPrestamo1,
    $uuid)