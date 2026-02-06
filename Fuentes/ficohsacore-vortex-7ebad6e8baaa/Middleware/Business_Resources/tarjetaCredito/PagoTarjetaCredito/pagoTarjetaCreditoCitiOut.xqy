xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoderecaudolocalylineadbctaResponse1" element="ns0:PagoderecaudolocalylineadbctaResponse" location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="pagoTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoCitiOut4/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:pagoTarjetaCreditoCitiOut4($pagoderecaudolocalylineadbctaResponse1 as element(ns0:PagoderecaudolocalylineadbctaResponse),
    $balanceCurrency as xs:string,
    $tasaCambioCompra as xs:string,
    $tasaCambioVenta as xs:string)
    as element(ns1:pagoTarjetaCreditoResponse) {
        <ns1:pagoTarjetaCreditoResponse>
            {
                for $DEBITCURRENCY in $pagoderecaudolocalylineadbctaResponse1/FUNDSTRANSFERType/DEBITCURRENCY
                return
                    <PAYMENT_CURRENCY>{ data($DEBITCURRENCY) }</PAYMENT_CURRENCY>
            }
            {
                let $debitCurrency := $pagoderecaudolocalylineadbctaResponse1/FUNDSTRANSFERType/DEBITCURRENCY
                let $DEBITAMOUNT := $pagoderecaudolocalylineadbctaResponse1/FUNDSTRANSFERType/DEBITAMOUNT
                return
                                                	                                                                            
                    if (($balanceCurrency) = ($debitCurrency)) then (                    	
                    	<BALANCE_PAYMENT>{ data($DEBITAMOUNT) }</BALANCE_PAYMENT>											
					) else (
						if (($balanceCurrency) = "HNL") then (
							 let $balancePayment := fn-bea:format-number(( $DEBITAMOUNT * xs:decimal($tasaCambioCompra)),".00") 
							 return
							 <BALANCE_PAYMENT>{ data($balancePayment) }</BALANCE_PAYMENT>
											)
						else(
							let $balancePayment := fn-bea:format-number(( $DEBITAMOUNT div xs:decimal($tasaCambioVenta)),".00")
							 return
							 <BALANCE_PAYMENT>{ data($balancePayment) }</BALANCE_PAYMENT>
						)
											
						
						
																	
					)
                    
                    
            }
            <BALANCE_CURRENCY>{ $balanceCurrency }</BALANCE_CURRENCY>
            {
                for $DEBITACCTNO in $pagoderecaudolocalylineadbctaResponse1/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                let $result :=
                    for $DATETIME in $pagoderecaudolocalylineadbctaResponse1/FUNDSTRANSFERType/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
                return
                    $result[1]
            }
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $pagoderecaudolocalylineadbctaResponse1 as element(ns0:PagoderecaudolocalylineadbctaResponse) external;
declare variable $balanceCurrency as xs:string external;
declare variable $tasaCambioCompra as xs:string external;
declare variable $tasaCambioVenta as xs:string external;

xf:pagoTarjetaCreditoCitiOut4($pagoderecaudolocalylineadbctaResponse1,
    $balanceCurrency,
    $tasaCambioCompra,
    $tasaCambioVenta)