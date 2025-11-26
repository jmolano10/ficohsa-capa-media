(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../xsds/Transferencias/XMLSchema_1840876228.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/TransfmodelbankentrecuentasIn/";

declare function xf:TransfmodelbankentrecuentasIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $creditAccount as xs:string,
    $accountCurrency as xs:string,
    $uuid as xs:string,
    $transactionType as xs:string
    )
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
            	<TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                {
                    for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                    return
                        <DEBITACCTNO>{ data($DEBIT_ACCOUNT) }</DEBITACCTNO>
                }
                <DEBITCURRENCY>{ $accountCurrency }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCTNO>{ $creditAccount }</CREDITACCTNO>
                {
                	if( substring($pagoPrestamo/DEBIT_ACCOUNT,1,3) = ("HNL","USD") ) then (
		                <gORDERINGBANK g = "1">
		                    <ORDERINGBANK>999999</ORDERINGBANK>
		                </gORDERINGBANK>
                	) else()
                }                 

				<gPAYMENTDETAILS g="1">
                {
                    for $LOAN_NUMBER in $pagoPrestamo/LOAN_NUMBER
                    return
                    <PAYMENTDETAILS>{ fn:concat("PTM-",data($LOAN_NUMBER)) }</PAYMENTDETAILS>    
                }     	        	
               	</gPAYMENTDETAILS>                                      
                            
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $creditAccount as xs:string external;
declare variable $accountCurrency as xs:string external;
declare variable $uuid as xs:string external;
declare variable $transactionType as xs:string external;

xf:TransfmodelbankentrecuentasIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $creditAccount,
    $accountCurrency,
    $uuid,
    $transactionType
    )