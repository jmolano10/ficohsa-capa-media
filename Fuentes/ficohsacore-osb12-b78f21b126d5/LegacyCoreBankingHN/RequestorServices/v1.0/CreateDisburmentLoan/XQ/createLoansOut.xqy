xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/loansTypes";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/loansTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/desembolsaPrestamo";
(:: import schema at "../../../../ProviderServices/XSD/CreateLoans/createLoans_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createLoansOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $CreateLoans_SPResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function ns1:createLoansOut($uuid as xs:string, $CreateLoans_SPResponse as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns3:createDisbursementLoanResponse) ::) {
    <ns3:createDisbursementLoanResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            for $PT_TIPO_GASTO_ITEM in $CreateLoans_SPResponse/ns2:PT_TIPO_GASTO/ns2:PT_TIPO_GASTO_ITEM
            return 
            <ns3:ExpensesDetails>
                {
                    if ($PT_TIPO_GASTO_ITEM/ns2:TIPO)
                    then <ns3:Type>{fn:data($PT_TIPO_GASTO_ITEM/ns2:TIPO)}</ns3:Type>
                    else ()
                }
                {
                    if ($PT_TIPO_GASTO_ITEM/ns2:MONTO)
                    then <ns3:Amount>{fn:data($PT_TIPO_GASTO_ITEM/ns2:MONTO)}</ns3:Amount>
                    else ()
                }
                {
                    if ($PT_TIPO_GASTO_ITEM/ns2:REFERENCIA_TRANSACCION and (string($PT_TIPO_GASTO_ITEM/ns2:REFERENCIA_TRANSACCION/text())!= ''))
                    then <ns3:TransactionReference>{fn:data($PT_TIPO_GASTO_ITEM/ns2:REFERENCIA_TRANSACCION)}</ns3:TransactionReference>
                    else ()
                }</ns3:ExpensesDetails>
        }
        {
            for $PT_DETALLE_DESEMBOLSO_ITEM in $CreateLoans_SPResponse/ns2:PT_DETALLE_DESEMBOLSO/ns2:PT_DETALLE_DESEMBOLSO_ITEM
            return 
            <ns3:DisbursementDetails>
                {
                    if ($PT_DETALLE_DESEMBOLSO_ITEM/ns2:TIPO_PRODUCTO)
                    then <ns3:ProductType>{fn:data($PT_DETALLE_DESEMBOLSO_ITEM/ns2:TIPO_PRODUCTO)}</ns3:ProductType>
                    else ()
                }
                {
                    if ($PT_DETALLE_DESEMBOLSO_ITEM/ns2:NUMERO_PRODUCTO)
                    then <ns3:ProductNumber>{fn:data($PT_DETALLE_DESEMBOLSO_ITEM/ns2:NUMERO_PRODUCTO)}</ns3:ProductNumber>
                    else ()
                }
                {
                    if ($PT_DETALLE_DESEMBOLSO_ITEM/ns2:TIPO_MONEDA)
                    then <ns3:ProductCurrency>{fn:data($PT_DETALLE_DESEMBOLSO_ITEM/ns2:TIPO_MONEDA)}</ns3:ProductCurrency>
                    else ()
                }
                {
                    if ($PT_DETALLE_DESEMBOLSO_ITEM/ns2:MONTO)
                    then <ns3:Amoun>{fn:data($PT_DETALLE_DESEMBOLSO_ITEM/ns2:MONTO)}</ns3:Amoun>
                    else ()
                }
                {
                    if ($PT_DETALLE_DESEMBOLSO_ITEM/ns2:REFERENCIA_TRANSACCION and (string($PT_DETALLE_DESEMBOLSO_ITEM/ns2:REFERENCIA_TRANSACCION/text())!= ''))
                    then <ns3:TransactionReference>{fn:data($PT_DETALLE_DESEMBOLSO_ITEM/ns2:REFERENCIA_TRANSACCION)}</ns3:TransactionReference>
                    else ()
                }
                {
                    for $DATOS_ADICIONALES_ITEM in $PT_DETALLE_DESEMBOLSO_ITEM/ns2:DATOS_ADICIONALES/ns2:DATOS_ADICIONALES_ITEM
                    return 
                    <ns3:AdditionalData>
                        {
                            if ($DATOS_ADICIONALES_ITEM/ns2:KEY)
                            then <ns3:KeyValue>{fn:data($DATOS_ADICIONALES_ITEM/ns2:KEY)}</ns3:KeyValue>
                            else ()
                        }
                        {
                            if ($DATOS_ADICIONALES_ITEM/ns2:VALOR)
                            then <ns3:Value>{fn:data($DATOS_ADICIONALES_ITEM/ns2:VALOR)}</ns3:Value>
                            else ()
                        }</ns3:AdditionalData>
                }</ns3:DisbursementDetails>
        }
    </ns3:createDisbursementLoanResponse>
};

ns1:createLoansOut($uuid, $CreateLoans_SPResponse)
