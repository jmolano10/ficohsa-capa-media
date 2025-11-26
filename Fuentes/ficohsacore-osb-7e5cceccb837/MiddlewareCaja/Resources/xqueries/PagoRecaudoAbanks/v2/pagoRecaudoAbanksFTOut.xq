(:: pragma bea:local-element-parameter parameter="$fUNDSTRANSFERType1" type="ns0:Pagoderecaudoreferenciadodbcta_ValidateResponse/FUNDSTRANSFERType" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../xsds/PagoRecaudoAbanks/pagoRecaudoAbanks/v2/pagoRecaudoAbanks_v2_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoAbanks1" element="ns2:pagoRecaudoAbanks" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse1" element="ns0:ConsultadeparametroscoreResponse" location="../../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns2:pagoRecaudoAbanksResponse" location="../../../xsds/PagoRecaudoAbanks/PagoRecaudoAbanks.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoAbanksTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoRecaudoAbanks_v2";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoAbanks/v2/pagoRecaudoAbanksFTOut/";

declare function xf:pagoRecaudoAbanksFTOut($fUNDSTRANSFERType1 as element(),
    $outputParameters1 as element(ns1:OutputParameters),
    $pagoRecaudoAbanks1 as element(ns2:pagoRecaudoAbanks),
    $consultadeparametroscoreResponse1 as element(ns0:ConsultadeparametroscoreResponse))
    as element(ns2:pagoRecaudoAbanksResponse) {
        <ns2:pagoRecaudoAbanksResponse>
            {
                for $PV_NOMBRE_CONTRATO in $outputParameters1/ns1:PV_NOMBRE_CONTRATO
                return
                    <CONTRACT_NAME>{ data($PV_NOMBRE_CONTRATO) }</CONTRACT_NAME>
            }
            <DEBTOR_CODE>{ data($pagoRecaudoAbanks1/DEBTOR_CODE) }</DEBTOR_CODE>
            {
                for $PV_NOMBRE_DEUDOR in $outputParameters1/ns1:PV_NOMBRE_DEUDOR
                return
                    <DEBTOR_NAME>{ data($PV_NOMBRE_DEUDOR) }</DEBTOR_NAME>
            }
            <PAYMENT_CURRENCY>{ data($pagoRecaudoAbanks1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
            {
                let $BUYRATE := $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                let $SELLRATE := $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                return
                	if ( data($pagoRecaudoAbanks1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) = "HNL" ) then (
                		<EXCHANGE_RATE>{ data($SELLRATE) }</EXCHANGE_RATE>
                	) else (
                		<EXCHANGE_RATE>{ data($BUYRATE) }</EXCHANGE_RATE>
                	)
            }            
            {
                let $result :=
                    for $INPUTTER in $fUNDSTRANSFERType1/gINPUTTER/INPUTTER
                    return
                        <INPUTTER>{ fn:tokenize(data($INPUTTER), "_")[2] }</INPUTTER>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATETIME in $fUNDSTRANSFERType1/gDATETIME/DATETIME
                    return
                        <DATE_TIME>{ concat("20",data($DATETIME)) }</DATE_TIME>
                return
                    $result[1]
            }
            {
                for $USERAGENCYNAME in $consultadeparametroscoreResponse1/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/USERAGENCYNAME
                return
                    <BRANCH_NAME>{ data($USERAGENCYNAME) }</BRANCH_NAME>
            }
            {
                for $AMOUNT in $pagoRecaudoAbanks1/AMOUNT
                return
                    <TOTAL_AMOUNT>{ data($AMOUNT) }</TOTAL_AMOUNT>
            }
            {
                for $PV_RECIBO in $outputParameters1/ns1:PV_RECIBO
                return
                    <BILL_DETAIL>{ data($PV_RECIBO) }</BILL_DETAIL>
            }
        </ns2:pagoRecaudoAbanksResponse>
};

declare variable $fUNDSTRANSFERType1 as element() external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $pagoRecaudoAbanks1 as element(ns2:pagoRecaudoAbanks) external;
declare variable $consultadeparametroscoreResponse1 as element(ns0:ConsultadeparametroscoreResponse) external;

xf:pagoRecaudoAbanksFTOut($fUNDSTRANSFERType1,
    $outputParameters1,
    $pagoRecaudoAbanks1,
    $consultadeparametroscoreResponse1)