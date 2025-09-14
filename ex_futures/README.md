# ex_futures

Explaining futures

## Getting Started

This shows how FutureBuilder works. The main code is below.

  FutureBuilder<String>(
    future: loadFile('assets/$name'),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return Expanded(
          child: SingleChildScrollView(
            child: Text('File content: ${snapshot.data}'),
          ),
        );
      }
    },
  );