xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/loansTypes";
(:: import schema at "../../../../../MWBanking/Loans/RequestorServices/XSD/loansTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/desembolsaPrestamo";
(:: import schema at "../../../../ProviderServices/XSD/CreateLoans/createLoans_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/createLoansIn";

declare variable $username as xs:string external;
declare variable $createDisbursementLoanRequest as element() (:: schema-element(ns2:createDisbursementLoanRequest) ::) external;

declare function ns1:createLoansIn($username as xs:string, 
                                   $createDisbursementLoanRequest as element() (:: schema-element(ns2:createDisbursementLoanRequest) ::)) 
                                   as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        {
            if ($createDisbursementLoanRequest/ns2:CustomerId)
            then <ns3:PV_CODIGO_CLIENTE>{fn:data($createDisbursementLoanRequest/ns2:CustomerId)}</ns3:PV_CODIGO_CLIENTE>
            else ()
        }
        {
            if ($createDisbursementLoanRequest/ns2:LoanNumber)
            then <ns3:PV_NUMERO_PRESTAMO>{fn:data($createDisbursementLoanRequest/ns2:LoanNumber)}</ns3:PV_NUMERO_PRESTAMO>
            else ()
        }
        <ns3:PT_TIPO_GASTO>
            {
                for $ExpensesDetails in $createDisbursementLoanRequest/ns2:ExpensesDetails
                return 
                <ns3:PT_TIPO_GASTO_ITEM>
                    {
                        if ($ExpensesDetails/ns2:Type)
                        then <ns3:TIPO>{fn:data($ExpensesDetails/ns2:Type)}</ns3:TIPO>
                        else ()
                    }
                    {
                        if ($ExpensesDetails/ns2:Amount)
                        then <ns3:MONTO>{fn:data($ExpensesDetails/ns2:Amount)}</ns3:MONTO>
                        else ()
                    }</ns3:PT_TIPO_GASTO_ITEM>
            }</ns3:PT_TIPO_GASTO>
        {
            if ($createDisbursementLoanRequest/ns2:DisbursementDetails/ns2:AgencyCode)
            then <ns3:PV_CODIGO_AGENCIA>{fn:data($createDisbursementLoanRequest/ns2:DisbursementDetails/ns2:AgencyCode)}</ns3:PV_CODIGO_AGENCIA>
            else ()
        }
        {
            if ($createDisbursementLoanRequest/ns2:DisbursementDetails/ns2:Description)
            then <ns3:PV_DESCRIPCION>{fn:data($createDisbursementLoanRequest/ns2:DisbursementDetails/ns2:Description)}</ns3:PV_DESCRIPCION>
            else ()
        }
        <ns3:PT_DETALLE_DESEMBOLSO>
            {
                for $DisbursementItem in $createDisbursementLoanRequest/ns2:DisbursementDetails/ns2:DisbursementItem
                return 
                <ns3:PT_DETALLE_DESEMBOLSO_ITEM>
                    {
                        if ($DisbursementItem/ns2:ProductType)
                        then <ns3:TIPO_PRODUCTO>{fn:data($DisbursementItem/ns2:ProductType)}</ns3:TIPO_PRODUCTO>
                        else ()
                    }
                    {
                        if ($DisbursementItem/ns2:ProductNumber)
                        then <ns3:NUMERO_PRODUCTO>{fn:data($DisbursementItem/ns2:ProductNumber)}</ns3:NUMERO_PRODUCTO>
                        else ()
                    }
                    {
                        if ($DisbursementItem/ns2:ProductCurrency)
                        then <ns3:TIPO_MONEDA>{fn:data($DisbursementItem/ns2:ProductCurrency)}</ns3:TIPO_MONEDA>
                        else ()
                    }
                    {
                        if ($DisbursementItem/ns2:Amount)
                        then <ns3:MONTO>{fn:data($DisbursementItem/ns2:Amount)}</ns3:MONTO>
                        else ()
                    }
                    <ns3:DATOS_ADICIONALES>
                        {
                            for $AdditionalData in $DisbursementItem/ns2:AdditionalData
                            return 
                            <ns3:DATOS_ADICIONALES_ITEM>
                                {
                                    if ($AdditionalData/ns2:KeyValue)
                                    then <ns3:KEY>{fn:data($AdditionalData/ns2:KeyValue)}</ns3:KEY>
                                    else ()
                                }
                                {
                                    if ($AdditionalData/ns2:Value)
                                    then <ns3:VALOR>{fn:data($AdditionalData/ns2:Value)}</ns3:VALOR>
                                    else ()
                                }</ns3:DATOS_ADICIONALES_ITEM>
                        }
                    </ns3:DATOS_ADICIONALES></ns3:PT_DETALLE_DESEMBOLSO_ITEM>
            }
        </ns3:PT_DETALLE_DESEMBOLSO>
        <ns3:PV_USUARIO_INTERFAZ>{fn:data($username)}</ns3:PV_USUARIO_INTERFAZ>
        {
            if ($createDisbursementLoanRequest/ns2:Inputter)
            then <ns3:PV_USUARIO_SISTEMA>{fn:data($createDisbursementLoanRequest/ns2:Inputter)}</ns3:PV_USUARIO_SISTEMA>
            else ()
        }
    </ns3:InputParameters>
};

ns1:createLoansIn($username, $createDisbursementLoanRequest)
