# Cryptography Strategy

Encryption is the most common mechanism to protect data from unintended disclosure or alteration,whether the data is being stored or transmitted. While it is possible to retroactively build encryption into a feature, it is easier, more efficient and more cost-effective to consider encryption during the design process. 

## Key Decisions
1. What to protect - The entity to protect - data in motion, data at rest, etc.
1. The goal of protection - To encrypt it or to hash it?
1. Mechanism of encryption - The algorithm to use and key length.
1. Key and Certificate management solution to use. - Windows Credential Manager, HSM, Azure Key Vault.

## Testing SSL:

### Server side tools
* [Comodo SSL analyzer](https://comodosslstore.com/ssltools/ssl-checker.php)
* [Globalsign SSL checker](https://globalsign.ssllabs.com/)
* [SSLLabs](https://www.ssllabs.com/ssltest/)
### Client side tools
* [How's my SSL](https://www.howsmyssl.com/)


SSLLabs assessment tools - https://github.com/ssllabs/research/wiki/Assessment-Tools

## Further Reading
[OWASP cryptographic cheat sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html)

