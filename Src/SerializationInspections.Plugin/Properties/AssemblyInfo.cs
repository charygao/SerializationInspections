using System.Reflection;

[assembly: AssemblyTitle(AssemblyConsts.Title)]
//

[assembly: AssemblyVersion("0.0.0.1")]
[assembly: AssemblyFileVersion("0.0.0.1")]
[assembly: AssemblyInformationalVersion("0.0.0.1-local")]

// ReSharper disable once CheckNamespace
internal static class AssemblyConsts
{
    public const string Title =
            "Serialization Inspections ReSharper Plugin"
#if DEBUG
            + " (Debug Build)"
#endif
        ;
}
