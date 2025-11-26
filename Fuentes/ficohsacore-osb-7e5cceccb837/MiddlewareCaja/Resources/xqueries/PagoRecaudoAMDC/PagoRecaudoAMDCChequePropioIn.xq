(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns3:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAMDC" element="ns0:pagoRecaudoAMDC" location="../../xsds/PagoRecaudoAMDC/PagoRecaudoAMDC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../xsds/Recaudos/ConsultarRelacionOperacionRecaudoAMDC/FLINK_OSB_CON_OPER_RECAUDO_AMDC.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Pagoderecaudoamdcficochq" location="../../xsds/PagoRecaudosAmdc/XMLSchema_-1803864288.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CON_OPER_RECAUDO_AMDC/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAMDCTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAMDC/PagoRecaudoAMDCChequePropioIn/";

declare function xf:PagoRecaudoAMDCChequePropioIn($autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader),
    $pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC),
    $outputParameters as element(ns2:OutputParameters),
    $uuid as xs:string)
    as element(ns1:Pagoderecaudoamdcficochq) {
        <ns1:Pagoderecaudoamdcficochq>
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
            <FUNDSTRANSFERLATAMFICCQPPWSType>
                {
                    for $DEBIT_ACCOUNT in $pagoRecaudoAMDC/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                    return
                        <DEBITACCTNO>{ data($DEBIT_ACCOUNT) }</DEBITACCTNO>
                }
                <PAYEECURRENCY>{ data($pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYEECURRENCY>
                {
                    for $PAYMENT_AMOUNT in $pagoRecaudoAMDC/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    return
                        <AMOUNT>{ data($PAYMENT_AMOUNT) }</AMOUNT>
                }
                {
                    for $CHEQUE_NUMBER in $pagoRecaudoAMDC/PAYMENT_INFORMATION/CHEQUE_NUMBER
                    return
                        <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                }
                <gLRINVOICENO>
                    {
                        for $MES at $i in ($outputParameters/ns2:MESES_A_PAGAR/ns2:ITEM)  
                        return
                            if (fn:string($MES/text()) != "") then (
                            	<mLRINVOICENO>
	                                <LRINVOICENO>{ fn:string($MES/text()) }</LRINVOICENO>
	                                <LRDUEDATE>{ data($outputParameters/ns2:FECHAS_A_PAGAR/ns2:ITEM[$i]) }</LRDUEDATE>
	                                <LRPAYYN>Y</LRPAYYN>
                                </mLRINVOICENO>
                            ) else ()
                    }
				</gLRINVOICENO>                    
                <LRIDENCODE>{ data($pagoRecaudoAMDC/DEBTOR_CODE) }</LRIDENCODE>
                <LRTAXYEAR>{ data($pagoRecaudoAMDC/YEAR_TO_PAY) }</LRTAXYEAR>
                <gLRTAXPAYNAME>
                    {
                        for $NOMB_DEUDOR in $outputParameters/ns2:NOMB_DEUDOR
                        return
                            <LRTAXPAYNAME>{ data($NOMB_DEUDOR) }</LRTAXPAYNAME>
                    }
                </gLRTAXPAYNAME>
                <LRAGCLIENTID>{ data($pagoRecaudoAMDC/CONTRACT_ID) }</LRAGCLIENTID>
                <LRIDENTYPE>{ data($pagoRecaudoAMDC/IDENTITY_TYPE) }</LRIDENTYPE>
            </FUNDSTRANSFERLATAMFICCQPPWSType>
        </ns1:Pagoderecaudoamdcficochq>
};

declare variable $autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoAMDC as element(ns0:pagoRecaudoAMDC) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;

xf:PagoRecaudoAMDCChequePropioIn($autenticacionRequestHeader,
    $pagoRecaudoAMDC,
    $outputParameters,
    $uuid)