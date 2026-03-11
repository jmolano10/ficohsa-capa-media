xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../Schemas/ObtenerTicket.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/user";
(:: import schema at "../../SBHN_Transfer_Commons/Schemas/UserLoginT24.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/transfer";
(:: import schema at "../Schemas/GetStatusTicketTypes.xsd" ::)

declare variable $input as element() (:: schema-element(ns1:getStatusTicket) ::) external;
declare variable $userConnInfo as element() (:: schema-element(ns2:connInfoElement) ::) external;

declare function local:funcGetStatusTicketToT24($input as element() (:: schema-element(ns1:getStatusTicket) ::), 
                                                $userConnInfo as element() (:: schema-element(ns2:connInfoElement) ::)) 
                                                as element() (:: schema-element(ns3:getStatusTicket) ::) {
    <ns3:getStatusTicket>
        <WebRequestCommon>
            <userName>{fn:data($userConnInfo/ns2:username)}</userName>
            <password>{fn:data($userConnInfo/ns2:password)}</password>
             <company></company>
        </WebRequestCommon>
        <FICOTRACKINGNUMBERWSType>
            <enquiryInputCollection>
               <columnName>@ID</columnName>
                <criteriaValue>{fn:data($input/Ticket)}</criteriaValue>
               <operand>LK</operand>
            </enquiryInputCollection>
        </FICOTRACKINGNUMBERWSType>
    </ns3:getStatusTicket>
};

local:funcGetStatusTicketToT24($input, $userConnInfo)
