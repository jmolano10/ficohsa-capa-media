xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/ingresaExpedienteTypes";
(:: import schema at "../../../../../../MWBanking/Documents/RequestorServices/XSD/ingresaExpedienteTypes.xsd" ::)
declare namespace ns3="http://www.ficohsa.com/midleware.services/ExpedientesAPITypes";
(:: import schema at "../../../../../ProviderServices/v1.0/XSD/TotalImage/ExpedientesAPITypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/middleware.services/enterDocumentIn";

declare variable $ingresaExpedienteRequest as element() (:: schema-element(ns2:ingresaExpedienteRequest) ::) external;

declare function ns1:enterDocumentIn($ingresaExpedienteRequest as element() (:: schema-element(ns2:ingresaExpedienteRequest) ::)) as element() (:: schema-element(ns3:getTransaction8Request) ::) {
    <ns3:getTransaction8Request>
        <ns3:TipoExpediente>{fn:data($ingresaExpedienteRequest/ns2:FileType)}</ns3:TipoExpediente>
        <ns3:tipo_documento>{fn:data($ingresaExpedienteRequest/ns2:DocumentType)}</ns3:tipo_documento>
        <ns3:categoria>{fn:data($ingresaExpedienteRequest/ns2:Categorie)}</ns3:categoria>
        {
            for $Keys in $ingresaExpedienteRequest/ns2:Keys
            return 
            <ns3:llaves>
                <ns3:nombre>{fn:data($Keys/ns2:Name)}</ns3:nombre>
                <ns3:valor>{fn:data($Keys/ns2:Value)}</ns3:valor></ns3:llaves>
        }
        {
            for $OriginAdress in $ingresaExpedienteRequest/ns2:OriginAdress
            return 
            <ns3:direccion_origen>
                {
                  if ($OriginAdress/ns2:Path) then
                    <ns3:path>{fn:data($OriginAdress/ns2:Path)}</ns3:path>
                  else  ()
                }
                {
                  if ($OriginAdress/ns2:PathOrigin) then
                    <ns3:pathOrigen>{fn:data($OriginAdress/ns2:PathOrigin)}</ns3:pathOrigen>
                  else  ()
                }
                {
                  if ($OriginAdress/ns2:User) then
                    <ns3:usuario>{fn:data($OriginAdress/ns2:User)}</ns3:usuario>
                  else  ()
                }
                {
                  if ($OriginAdress/ns2:Password) then
                    <ns3:password>{fn:data($OriginAdress/ns2:Password)}</ns3:password>
                  else  ()
                }
                {
                  if ($OriginAdress/ns2:Host) then
                    <ns3:servidor>{fn:data($OriginAdress/ns2:Host)}</ns3:servidor>
                  else  ()
                }  
              </ns3:direccion_origen>
        }
        {
            for $Pages in $ingresaExpedienteRequest/ns2:Pages
            return 
            <ns3:paginas>{fn:data($ingresaExpedienteRequest/ns2:Pages)}</ns3:paginas>
        }
        {
            for $RedisPages in $ingresaExpedienteRequest/ns2:RedisPages
            return 
            <ns3:paginasRedis>
                <ns3:extension>{fn:data($RedisPages/ns2:extension)}</ns3:extension>
                {
                    for $RedisKeys in $RedisPages/ns2:RedisKeys
                    return 
                    <ns3:LlavesRedis>{fn:data($RedisPages/ns2:RedisKeys)}</ns3:LlavesRedis>
                }</ns3:paginasRedis>
        }
        {
            for $DocumentKeys in $ingresaExpedienteRequest/ns2:DocumentKeys
            return 
            <ns3:llaves_documento>
                {
                  if ($DocumentKeys/ns2:Name) then
                    <ns3:nombre>{fn:data($DocumentKeys/ns2:Name)}</ns3:nombre>
                  else  ()
                }
                {
                  if ($DocumentKeys/ns2:Value) then
                    <ns3:valor>{fn:data($DocumentKeys/ns2:Value)}</ns3:valor>
                  else  ()
                }
            </ns3:llaves_documento>
        }
    </ns3:getTransaction8Request>
};

ns1:enterDocumentIn($ingresaExpedienteRequest)