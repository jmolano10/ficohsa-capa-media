(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Depositoefecenmonedaextranjera" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/DepositoEfectivoMonedaExtranjeraIn/";

declare function xf:DepositoEfectivoMonedaExtranjeraIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $depositAccount as xs:string,
    $uuid as xs:string)
    as element(ns1:Depositoefecenmonedaextranjera) {
        <ns1:Depositoefecenmonedaextranjera>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFICOHNANYCASHINFCYType>
                <CASHCURRENCY>USD</CASHCURRENCY>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <AMOUNTFOREING>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</AMOUNTFOREING>
                    </mACCOUNT1>
                </gACCOUNT1>
                <LRFICODEPOSIT>PAGO DE PRESTAMO</LRFICODEPOSIT>
                <ACCOUNT>{ $depositAccount }</ACCOUNT>
				<gNARRATIVE2 g="1">
                {
                    for $LOAN_NUMBER in $pagoPrestamo/LOAN_NUMBER
                    return
                    <NARRATIVE>{ fn:concat("PTM-",data($LOAN_NUMBER)) }</NARRATIVE>    
                }     	        	
               	</gNARRATIVE2>                                      
            </TELLERFICOHNANYCASHINFCYType>
        </ns1:Depositoefecenmonedaextranjera>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $depositAccount as xs:string external;
declare variable $uuid as xs:string external;

xf:DepositoEfectivoMonedaExtranjeraIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $depositAccount,
    $uuid)