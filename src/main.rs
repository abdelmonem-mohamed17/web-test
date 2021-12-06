use actix_web::{web, App, HttpRequest, HttpServer, Responder};

async fn health(_req: HttpRequest) -> impl Responder {
    "worked!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .route("/health", web::get().to(health))
    })
        .bind(("0.0.0.0", 8080))?
        .run()
        .await
}