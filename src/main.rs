//! ahelper
//!
//! A lightweight modular toolkit for sustainable ARM64 and Arch Linux systems.
//!
//! Modules live at:
//!
//! modules/<module>/main.sh

use clap::Parser;
use std::path::PathBuf;
use std::process::Command;

#[derive(Parser)]
#[command(name = "ahelper")]
#[command(about = "A toolkit for sustainable ARM64 Arch Linux systems")]
#[command(version)]
struct Cli {
    /// Module to run, e.g. `ahelper quarto`
    module: Option<String>,

    /// Arguments passed through to the selected module.
    #[arg(trailing_var_arg = true)]
    args: Vec<String>,
}

fn main() {
    let cli = Cli::parse();

    // println!("{}", cli.module);

    match cli.module {

        Some(module_name) => {
            println!("{}", module_name);
            if let Err(err) = run_module(&module_name, &cli.args) {
                eprintln!("ahelper error: {err}");
                std::process::exit(1);
            }
        }
        None => print_help_hint(),
    }
}


// Run module
fn run_module(module_name: &str, module_args: &[String]) -> Result<(), String> {

    let script = module_script_path(module_name);

    println!("{}", script.display());

    if !script.exists() {
        return Err(format!("unknown or unimplemented module `{module_name}`"));
    }

    let status = Command::new(&script)
        .args(module_args)
        .status()
        .map_err(|err| format!("failed to execute `{}`: {err}",
                 script.display()))?;

    if !status.success() {
        return Err(format!("module `{module_name}` failed"));
    }

    Ok(())
}


/// Return the directory for a module.
///
/// ```
/// use ahelper::module_dir_path;
///
/// assert_eq!(
///     module_dir_path("memory"),
///     std::path::PathBuf::from("modules/memory")
/// );
/// ```
pub fn module_dir_path(module_name: &str) -> PathBuf {
    PathBuf::from("modules").join(module_name)
}


/// Return the main script path for a module.
///
/// ```
/// use ahelper::module_script_path;
///
/// assert_eq!(
///     module_script_path("memory"),
///     std::path::PathBuf::from("modules/memory/main.sh")
/// );
/// ```
pub fn module_script_path(module_name: &str) -> PathBuf {
    module_dir_path(module_name).join("main.sh")
}

fn print_help_hint() {
    println!("ahelper\n");
    println!("Usage:");
    println!("    ahelper <module> [args]\n");
    println!("Examples:");
    println!("    ahelper quarto --no-oq");
    println!("    ahelper swap setup --size 16G");
    println!("    ahelper efficiency-report\n");
    println!("Run `ahelper --help` for CLI help.");
}
