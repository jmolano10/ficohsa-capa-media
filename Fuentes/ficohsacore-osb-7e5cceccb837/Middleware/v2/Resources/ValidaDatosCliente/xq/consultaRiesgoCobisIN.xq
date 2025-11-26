(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/ConsultaRiesgoCobis/xsd/ConsultaRiesgoCobis.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRiesgoCobis";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/consultaRiesgoCobisIN/";

declare function xf:consultaRiesgoCobisIN($Country as xs:string,
    $User as xs:string,
    $CostumerID as xs:string,
    $Channel as xs:string,
    $Date as xs:string,
    $orignsFounds as xs:string,
    $ProposeAccount as xs:string,
    $RiskCobisTrx as xs:string,
    $NumDebitTrx as xs:string,
    $NumCreditTrx as xs:string,
    $AmountAvgCredit as xs:string,
    $AmountAvgDebit as xs:string,
    $Currency  as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_pais>{ $Country }</ns0:i_pais>
            <ns0:i_user>{ $User }</ns0:i_user>
            <ns0:i_canal>{ $Channel }</ns0:i_canal>
            <ns0:i_fecha>{data($Date) }</ns0:i_fecha>
            <ns0:t_trn>{ data($RiskCobisTrx) }</ns0:t_trn>
            <ns0:i_oficina></ns0:i_oficina>
            <ns0:i_num_cliente>{ data($CostumerID) }</ns0:i_num_cliente>
            <ns0:i_proposito_cta>{ $ProposeAccount }</ns0:i_proposito_cta>
            <ns0:i_origen_fondos>{ $orignsFounds }</ns0:i_origen_fondos>
            <ns0:i_num_tran_deb>{ data($NumDebitTrx) }</ns0:i_num_tran_deb> 
            <ns0:i_monto_pro_deb>{ data($AmountAvgDebit) }</ns0:i_monto_pro_deb> 
            <ns0:i_num_tran_cre>{ data($NumCreditTrx) }</ns0:i_num_tran_cre>   
            <ns0:i_monto_pro_cre>{ data($AmountAvgCredit) }</ns0:i_monto_pro_cre>         
            <ns0:i_moneda>{ data($Currency) }</ns0:i_moneda>      
        </ns0:InputParameters>
};

declare variable $Country as xs:string external;
declare variable $User as xs:string external;
declare variable $CostumerID as xs:string external;
declare variable $Channel as xs:string external;
declare variable $Date as xs:string external;
declare variable $orignsFounds as xs:string external;
declare variable $ProposeAccount as xs:string external;
declare variable $RiskCobisTrx as xs:string external;
declare variable $NumDebitTrx as xs:string external;
declare variable $NumCreditTrx as xs:string external;
declare variable $AmountAvgCredit as xs:string external;
declare variable $AmountAvgDebit as xs:string external;
declare variable $Currency as xs:string external;

xf:consultaRiesgoCobisIN($Country,
    $User,
    $CostumerID,
    $Channel,
    $Date,
    $orignsFounds,
    $ProposeAccount,
    $RiskCobisTrx,
    $NumDebitTrx,
    $NumCreditTrx,
    $AmountAvgCredit,
    $AmountAvgDebit,
    $Currency)
