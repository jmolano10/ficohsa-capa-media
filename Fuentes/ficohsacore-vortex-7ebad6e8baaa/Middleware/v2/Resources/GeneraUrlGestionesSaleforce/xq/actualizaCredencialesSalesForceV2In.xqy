xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaUrlGestionesSaleforce1" element="ns1:generaUrlGestionesSaleforce" location="../xsd/generaUrlGestionesSaleforceTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SolicitaUrlSegura" location="../../../BusinessServices/SALESFORCE/generaUrlSegura/xsd/solicitaUrlSegura_1.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaUrlGestionesSaleforceTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/SolicitaUrlSeguraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraUrlGestionesSaleforce/xq/actualizaCredencialesSalesForceV2In/";

declare function xf:actualizaCredencialesSalesForceV2In($generaUrlGestionesSaleforce1 as element(ns1:generaUrlGestionesSaleforce),
    $Canal as xs:string,
    $NombreApiFlujo as xs:string,
    $PaisOrigen as xs:string,
    $SessionId as xs:string,
    $TipoId as xs:string)
    as element(ns0:SolicitaUrlSegura) {
        <ns0:SolicitaUrlSegura>
            <pEntrada>
                <IdCliente>{ data($generaUrlGestionesSaleforce1/CUSTOMER_FILTER/CUSTOMER_ID_VALUE) }</IdCliente>
                <TipoId>{ $TipoId }</TipoId>
                <Canal>{ $Canal }</Canal>
                <NombreApiFlujoADisparar>{ $NombreApiFlujo }</NombreApiFlujoADisparar>
                <PaisOrigen>
                    {
                        let $ConverPais  := ($PaisOrigen)  
                        return
                            if ($ConverPais = 'HN01') then
                                ('HONDURAS')
                            else 
                                if ($ConverPais = 'GT01') then
                                    ('GUATEMALA')
                                else 
                                    if ($ConverPais = 'NI01') then
                                        ('NICARAGUA')
                                    else 
                                        if ($ConverPais = 'PA01') then
                                            ('PANAMA')
                                        else 
                                            ()
                    }
</PaisOrigen>
            </pEntrada>
            <SessionId>{ $SessionId }</SessionId>
        </ns0:SolicitaUrlSegura>
};

declare variable $generaUrlGestionesSaleforce1 as element(ns1:generaUrlGestionesSaleforce) external;
declare variable $Canal as xs:string external;
declare variable $NombreApiFlujo as xs:string external;
declare variable $PaisOrigen as xs:string external;
declare variable $SessionId as xs:string external;
declare variable $TipoId as xs:string external;

xf:actualizaCredencialesSalesForceV2In($generaUrlGestionesSaleforce1,
    $Canal,
    $NombreApiFlujo,
    $PaisOrigen,
    $SessionId,
    $TipoId)