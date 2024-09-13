#pragma once
#include "FoamInterface.h"

#include <MooseMesh.h>

#include <memory>

namespace Hippo
{
class Foam2MooseMeshAdapter;
}
namespace Foam
{
template <typename T>
class IOList;
typedef int label;
typedef IOList<label> labelIOList;
}

class FoamMesh : public MooseMesh
{
public:
  static InputParameters validParams();
  FoamMesh(InputParameters const & params);
  FoamMesh(const FoamMesh & other_mesh);
  ~FoamMesh(); //{ _interface->dropInstance(); };
  virtual std::unique_ptr<MooseMesh> safeClone() const override;
  virtual void buildMesh() override;
  Hippo::FoamInterface * getFoamInterface() { return _interface; }
  std::vector<int> & getSubdomainList();
  bool isSerial() const { return _serial; }
  libMesh::Elem * getElemPtr(int local) const;

  std::vector<int32_t> n_faces{0};
  // The index offset into the MOOSE element array, for the current rank.
  // This can be used with `getElemPtr` like so:
  //     getElemPtr(rank_offset + i)
  // to get the i-th element owned by the current rank from the mesh.
  size_t rank_element_offset{0};

protected:
  std::vector<std::string> _foam_patch;
  std::vector<int32_t> _patch_id;
  Hippo::FoamInterface * _interface;
  std::vector<int> _subdomain_list;
  bool _serial = true;
};
// Local Variables:
// mode: c++
// End:
